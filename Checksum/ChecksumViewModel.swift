//
//  ChecksumViewModel.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI
import CryptoKit

@MainActor
class ChecksumViewModel: ObservableObject {
    @Published var selectedFile: URL?
    @Published var hashResult: HashResult?
    @Published var isCalculating = false
    @Published var progress: Double = 0
    
    private var calculationTask: Task<Void, Never>?
    
    var isFileSelected: Bool {
        selectedFile != nil
    }
    
    func selectFile(_ url: URL) {
        selectedFile = url
        calculateHashes()
    }
    
    func calculateHashes() {
        guard let fileURL = selectedFile else { return }
        
        isCalculating = true
        progress = 0
        
        calculationTask = Task {
            do {
                let fileSize = try FileHandle(forReadingFrom: fileURL).seekToEnd()
                try FileHandle(forReadingFrom: fileURL).seek(toOffset: 0)
                
                let chunkSize = 1024 * 1024 // 1MB chunks
                var md5Context = Insecure.MD5()
                var sha1Context = Insecure.SHA1()
                var sha256Context = SHA256()
                
                let fileHandle = try FileHandle(forReadingFrom: fileURL)
                var readSize: UInt64 = 0
                
                while let data = try fileHandle.read(upToCount: chunkSize) {
                    if Task.isCancelled { break }
                    
                    md5Context.update(data: data)
                    sha1Context.update(data: data)
                    sha256Context.update(data: data)
                    
                    readSize += UInt64(data.count)
                    await MainActor.run {
                        progress = Double(readSize) / Double(fileSize)
                    }
                }
                
                if !Task.isCancelled {
                    let result = HashResult(
                        md5: md5Context.finalize().map { String(format: "%02hhx", $0) }.joined(),
                        sha1: sha1Context.finalize().map { String(format: "%02hhx", $0) }.joined(),
                        sha256: sha256Context.finalize().map { String(format: "%02hhx", $0) }.joined()
                    )
                    
                    await MainActor.run {
                        hashResult = result
                        isCalculating = false
                    }
                }
                
            } catch {
                print("Error reading file: \(error)")
                await MainActor.run {
                    isCalculating = false
                }
            }
        }
    }
    
    func cancelCalculation() {
        calculationTask?.cancel()
        calculationTask = nil
        isCalculating = false
    }
    
    deinit {
        calculationTask?.cancel()
        calculationTask = nil
    }
}
