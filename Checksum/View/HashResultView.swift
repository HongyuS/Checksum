//
//  HashResultView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/14.
//

import SwiftUI

struct HashResultView: View {
    @ObservedObject var viewModel: ChecksumViewModel
    
    var body: some View {
        VStack {
            if viewModel.isCalculating {
                Spacer()
                
                HashProgressView(
                    progress: viewModel.progress,
                    message: "正在计算校验和..."
                )
                
                Spacer()
            }
            
            if viewModel.isFileSelected && !viewModel.isCalculating {
                Text("已选择文件: \(viewModel.selectedFile?.lastPathComponent ?? "")")
                    .padding()
                
                if let result = viewModel.hashResult {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 10) {
                            HashRow(title: "MD5", hash: result.md5)
                            HashRow(title: "SHA1", hash: result.sha1)
                            HashRow(title: "SHA256", hash: result.sha256)
                            HashRow(title: "SHA384", hash: result.sha384)
                            HashRow(title: "SHA512", hash: result.sha512)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .frame(minWidth: 512)
    }
}
