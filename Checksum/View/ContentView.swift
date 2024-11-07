//
//  ContentView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChecksumViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("文件校验和计算器")
                .font(.title)
                .padding()
            
            DropZoneView(selectedFile: $viewModel.selectedFile) {
                viewModel.calculateHashes()
            }
            .onTapGesture {
                selectFile()
            }
            
            if viewModel.isCalculating {
                HashProgressView(
                    progress: viewModel.progress,
                    message: "正在计算校验和..."
                )
            }
            
            if viewModel.isFileSelected && !viewModel.isCalculating {
                Text("已选择文件: \(viewModel.selectedFile?.lastPathComponent ?? "")")
                    .padding()
                
                if let result = viewModel.hashResult {
                    Group {
                        HashRow(title: "MD5", hash: result.md5)
                        HashRow(title: "SHA1", hash: result.sha1)
                        HashRow(title: "SHA256", hash: result.sha256)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onDisappear {
            viewModel.cancelCalculation()
        }
    }
    
    private func selectFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        
        if panel.runModal() == .OK {
            viewModel.selectFile(panel.url!)
        }
    }
}

#Preview {
    ContentView()
}
