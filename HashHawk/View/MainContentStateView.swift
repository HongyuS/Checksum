//
//  MainContentStateView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import SwiftUI

struct MainContentStateView: View {
    @Bindable var viewModel: HashHawkViewModel

    var body: some View {
        switch viewModel.mainContentState {
        case .idle:
            ContentUnavailableView(
                "等待文件",
                systemImage: "doc.badge.plus",
                description: Text("从左侧边栏拖放文件，或使用右上角打开文件。")
            )
            .frame(maxWidth: .infinity, minHeight: 320)

        case .calculating:
            HashProgressView(
                progress: viewModel.progress,
                message: "正在生成 MD5、SHA1、SHA256、SHA384 和 SHA512…"
            )

        case .result(let result):
            VStack(spacing: HashHawkLayout.sectionSpacing) {
                HashResultView(result: result)
                HashCompareView(viewModel: viewModel)
            }

        case .error(let errorMessage):
            ChecksumCard {
                VStack(alignment: .leading, spacing: HashHawkLayout.contentSpacing) {
                    Label("无法读取文件", systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)

                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    MainContentStateView(viewModel: HashHawkViewModel())
        .padding()
}
