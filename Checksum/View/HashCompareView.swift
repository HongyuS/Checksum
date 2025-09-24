//
//  HashCompareView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2025/09/24.
//

import SwiftUI

struct HashCompareView: View {
    @ObservedObject var viewModel: ChecksumViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // 分隔线
            Divider()
                .padding(.trailing)
            
            // 比较功能标题
            HStack {
                Text("校验和比较")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                
                // 比较结果
                if let comparison = viewModel.comparisonResult {
                    ComparisonResultView(comparison: comparison)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                if !viewModel.compareText.isEmpty {
                    Button("清除") {
                        viewModel.clearComparison()
                    }
                    .buttonStyle(.link)
                }
            }
            .padding(.trailing)
            
            // 输入框
                
            TextField("输入或粘贴哈希值...", text: $viewModel.compareText, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .focused($isTextFieldFocused)
                .lineLimit(2...4)
                .padding(.trailing)
                .font(.system(.body, design: .monospaced))
                .onChange(of: viewModel.compareText) { oldValue, newValue in
                    viewModel.compareHash(newValue)
                }
        }
        .padding(.vertical)
        .contentShape(.containerRelative)
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

struct ComparisonResultView: View {
    let comparison: HashComparisonResult
    
    var body: some View {
        HStack(spacing: 12) {
            // 状态图标
            Image(systemName: comparison.isMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title2)
                .foregroundStyle(comparison.isMatch ? .green : .red)
            
            HStack(alignment: .top, spacing: 8) {
                // 结果文本
                Text(comparison.isMatch ? "哈希值匹配" : "哈希值不匹配")
                    .font(.headline)
                    .foregroundStyle(comparison.isMatch ? .green : .red)
                
                if comparison.isMatch, let hashType = comparison.hashType {
                    Text("\(hashType)")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .animation(.easeInOut(duration: 0.3), value: comparison.isMatch)
    }
}
