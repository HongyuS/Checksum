//
//  ContentView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI
import CryptoKit
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var selectedFile: URL?
    @State private var md5Hash: String = ""
    @State private var sha1Hash: String = ""
    @State private var sha256Hash: String = ""
    @State private var isFileSelected = false
    @State private var isCalculating = false
    @State private var progress: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("文件校验和计算器")
                .font(.title)
                .padding()
            
            DropZoneView(selectedFile: $selectedFile) {
                isFileSelected = true
                calculateHashes()
            }
            .onTapGesture {
                selectFile()
            }
            
            if isCalculating {
                HashProgressView(
                    progress: progress,
                    message: "正在计算校验和..."
                )
            }
            
            if isFileSelected && !isCalculating {
                Text("已选择文件: \(selectedFile?.lastPathComponent ?? "")")
                    .padding()
                
                Group {
                    HashRow(title: "MD5", hash: md5Hash)
                    HashRow(title: "SHA1", hash: sha1Hash)
                    HashRow(title: "SHA256", hash: sha256Hash)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func selectFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        
        if panel.runModal() == .OK {
            selectedFile = panel.url
            isFileSelected = true
            calculateHashes()
        }
    }
    
    private func calculateHashes() {
        guard let fileURL = selectedFile else { return }
        
        isCalculating = true
        progress = 0
        
        DispatchQueue.global(qos: .userInitiated).async {
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
                    md5Context.update(data: data)
                    sha1Context.update(data: data)
                    sha256Context.update(data: data)
                    
                    readSize += UInt64(data.count)
                    let currentProgress = Double(readSize) / Double(fileSize)
                    
                    DispatchQueue.main.async {
                        progress = currentProgress
                    }
                }
                
                let md5Result = md5Context.finalize()
                let sha1Result = sha1Context.finalize()
                let sha256Result = sha256Context.finalize()
                
                DispatchQueue.main.async {
                    md5Hash = md5Result.map { String(format: "%02hhx", $0) }.joined()
                    sha1Hash = sha1Result.map { String(format: "%02hhx", $0) }.joined()
                    sha256Hash = sha256Result.map { String(format: "%02hhx", $0) }.joined()
                    isCalculating = false
                }
                
            } catch {
                print("Error reading file: \(error)")
                DispatchQueue.main.async {
                    isCalculating = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
