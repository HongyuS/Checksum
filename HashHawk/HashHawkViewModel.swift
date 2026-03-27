//
//  HashHawkViewModel.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import CryptoKit
import Observation
import SwiftUI
import UniformTypeIdentifiers

@MainActor
@Observable
final class HashHawkViewModel {
    var selectedFile: URL?
    var selectedFileDisplayPath = ""
    var selectedFileSize: Int64 = 0
    var fileIcon: NSImage?
    var hashResult: HashResult?
    var isCalculating = false
    var progress: Double = 0
    var compareText = ""
    var comparisonResult: HashComparisonResult?
    var errorMessage: String?
    
    @ObservationIgnored private var calculationTask: Task<Void, Never>?
    @ObservationIgnored private var scopedAccessURL: URL?
    
    var isFileSelected: Bool {
        selectedFile != nil
    }
    
    var fileSize: Int64 {
        selectedFileSize
    }
    
    var formattedFileSize: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB, .useTB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: fileSize)
    }

    var mainContentState: MainContentState {
        if isCalculating {
            return .calculating
        }

        if let hashResult {
            return .result(hashResult)
        }

        if let errorMessage {
            return .error(errorMessage)
        }

        return .idle
    }
    
    func selectFile(_ url: URL) {
        cancelCalculation()
        stopAccessingSelectedFile()
        selectedFileDisplayPath = Self.displayPath(for: url)
        selectedFile = url.standardizedFileURL
        errorMessage = nil
        hashResult = nil
        progress = 0
        beginAccessingSelectedFile()
        refreshSelectedFilePresentation()
        clearComparison()
        calculateHashes()
    }
    
    func calculateHashes() {
        guard let selectedFile else { return }
        
        cancelCalculation()
        hashResult = nil
        comparisonResult = nil
        errorMessage = nil
        isCalculating = true
        progress = 0
        
        calculationTask = Task(priority: .userInitiated) { [weak self, selectedFile] in
            guard let self else { return }
            
            do {
                let result = try await Self.hashFile(at: selectedFile) { progress in
                    await self.updateProgress(progress)
                }
                
                guard !Task.isCancelled else { return }
                
                self.hashResult = result
                self.progress = 1
                self.isCalculating = false
                self.compareHash(self.compareText)
            } catch is CancellationError {
                self.isCalculating = false
            } catch {
                self.hashResult = nil
                self.isCalculating = false
                self.errorMessage = "无法读取“\(selectedFile.lastPathComponent)”。\(error.localizedDescription)"
            }
            
            self.calculationTask = nil
        }
    }
    
    func cancelCalculation() {
        calculationTask?.cancel()
        calculationTask = nil
        isCalculating = false
    }
    
    func compareHash(_ inputText: String) {
        guard let hashResult else {
            comparisonResult = nil
            return
        }
        
        let cleanedInput = inputText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacing(" ", with: "")
            .lowercased()
        
        guard !cleanedInput.isEmpty else {
            comparisonResult = nil
            return
        }
        
        let matchedHashType = HashType.allCases.first {
            $0.value(from: hashResult).lowercased() == cleanedInput
        }
        let matchedHash = matchedHashType.map { $0.value(from: hashResult) }
        
        comparisonResult = HashComparisonResult(
            inputHash: cleanedInput,
            matchedHash: matchedHash,
            hashType: matchedHashType?.rawValue,
            isMatch: matchedHash != nil
        )
    }
    
    func clearComparison() {
        compareText = ""
        comparisonResult = nil
    }
    
    private func updateProgress(_ progress: Double) {
        self.progress = progress
    }

    private func beginAccessingSelectedFile() {
        guard let selectedFile else { return }
        guard selectedFile.startAccessingSecurityScopedResource() else { return }
        scopedAccessURL = selectedFile
    }

    private func stopAccessingSelectedFile() {
        scopedAccessURL?.stopAccessingSecurityScopedResource()
        scopedAccessURL = nil
    }

    private func refreshSelectedFilePresentation() {
        guard let selectedFile else {
            selectedFileDisplayPath = ""
            selectedFileSize = 0
            fileIcon = nil
            return
        }

        let iconResourceValues = try? selectedFile.resourceValues(forKeys: [.effectiveIconKey])
        let effectiveIcon = iconResourceValues?.allValues[.effectiveIconKey] as? NSImage
        let workspaceIcon = effectiveIcon
            ?? NSWorkspace.shared.icon(for: UTType(filenameExtension: selectedFile.pathExtension) ?? .item)
        let resolvedIcon = (workspaceIcon.copy() as? NSImage) ?? workspaceIcon
        resolvedIcon.size = NSSize(width: 96, height: 96)
        fileIcon = resolvedIcon

        if let resourceValues = try? selectedFile.resourceValues(forKeys: [.fileSizeKey]),
           let resourceFileSize = resourceValues.fileSize {
            selectedFileSize = Int64(resourceFileSize)
            return
        }

        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: selectedFile.path())
            selectedFileSize = attributes[.size] as? Int64 ?? 0
        } catch {
            selectedFileSize = 0
        }
    }
    
    private static func hashFile(
        at fileURL: URL,
        progressDidChange: @escaping @Sendable (Double) async -> Void
    ) async throws -> HashResult {
        let startedAccessingSecurityScopedResource = fileURL.startAccessingSecurityScopedResource()
        defer {
            if startedAccessingSecurityScopedResource {
                fileURL.stopAccessingSecurityScopedResource()
            }
        }

        let fileHandle = try FileHandle(forReadingFrom: fileURL)
        defer { try? fileHandle.close() }
        
        let totalBytes = try fileHandle.seekToEnd()
        try fileHandle.seek(toOffset: 0)
        
        let chunkSize = 1_048_576
        var md5Context = Insecure.MD5()
        var sha1Context = Insecure.SHA1()
        var sha256Context = SHA256()
        var sha384Context = SHA384()
        var sha512Context = SHA512()
        var bytesRead: UInt64 = 0
        
        while !Task.isCancelled {
            let data = try fileHandle.read(upToCount: chunkSize) ?? Data()
            guard !data.isEmpty else { break }
            
            md5Context.update(data: data)
            sha1Context.update(data: data)
            sha256Context.update(data: data)
            sha384Context.update(data: data)
            sha512Context.update(data: data)
            
            bytesRead += UInt64(data.count)
            
            if totalBytes > 0 {
                await progressDidChange(Double(bytesRead) / Double(totalBytes))
            }
        }
        
        try Task.checkCancellation()
        
        if totalBytes == 0 {
            await progressDidChange(1)
        }
        
        return HashResult(
            md5: md5Context.finalize().map(Self.hexString).joined(),
            sha1: sha1Context.finalize().map(Self.hexString).joined(),
            sha256: sha256Context.finalize().map(Self.hexString).joined(),
            sha384: sha384Context.finalize().map(Self.hexString).joined(),
            sha512: sha512Context.finalize().map(Self.hexString).joined()
        )
    }
    
    private static func hexString(for byte: UInt8) -> String {
        byte < 16 ? "0\(String(byte, radix: 16))" : String(byte, radix: 16)
    }

    private static func displayPath(for url: URL) -> String {
        url.path(percentEncoded: false)
    }
    
}
