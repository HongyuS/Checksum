//
//  HashResultView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/14.
//

import SwiftUI

enum HashType: String, CaseIterable, Identifiable {
    case md5 = "MD5"
    case sha1 = "SHA1"
    case sha256 = "SHA256"
    case sha384 = "SHA384"
    case sha512 = "SHA512"
    
    var id: String { rawValue }
}

struct HashResultView: View {
    @ObservedObject var viewModel: ChecksumViewModel
    @State private var selectedHashType: HashType = .md5
    
    var body: some View {
        VStack {
            if viewModel.isCalculating {
                Spacer()
                
                HashProgressView(
                    progress: viewModel.progress,
                    message: "正在计算校验和..."
                )
                .padding(.trailing)
                
                Spacer()
            }
            
            if viewModel.isFileSelected && !viewModel.isCalculating {
                // 文件信息显示
                HStack(spacing: 12) {
                    // 文件图标 - 使用真实的文件图标
                    Group {
                        if let nsImage = viewModel.fileIcon {
                            Image(nsImage: nsImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                        } else {
                            Image(systemName: "doc.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // 文件名和大小
                    VStack(alignment: .leading, spacing: 2) {
                        Text(viewModel.selectedFile?.lastPathComponent ?? "")
                            .font(.headline)
                        
                        Text(viewModel.formattedFileSize)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if let result = viewModel.hashResult {
                    VStack(spacing: 16) {
                        // Hash 类型选择器
                        Picker("Hash Type", selection: $selectedHashType) {
                            ForEach(HashType.allCases) { hashType in
                                Text(hashType.rawValue).tag(hashType)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        .padding(.trailing)
                        
                        // 选中的 hash 结果
                        HashRow(title: selectedHashType.rawValue, hash: getHashValue(for: selectedHashType, from: result))
                            .padding(.trailing)
                        
                        // 添加比较功能
                        HashCompareView(viewModel: viewModel)
                    }
                }
            }
        }
        .frame(minWidth: 512)
    }
    
    private func getHashValue(for type: HashType, from result: HashResult) -> String {
        switch type {
        case .md5:
            return result.md5
        case .sha1:
            return result.sha1
        case .sha256:
            return result.sha256
        case .sha384:
            return result.sha384
        case .sha512:
            return result.sha512
        }
    }
}
