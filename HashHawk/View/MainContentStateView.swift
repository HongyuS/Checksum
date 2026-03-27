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
                "mainContent.idle.title",
                systemImage: "doc.badge.plus",
                description: Text("mainContent.idle.description")
            )
            .frame(maxWidth: .infinity, minHeight: 320)

        case .calculating:
            HashProgressView(
                progress: viewModel.progress,
                message: "mainContent.calculating.message"
            )

        case .result(let result):
            VStack(spacing: HashHawkLayout.sectionSpacing) {
                HashResultView(result: result)
                HashCompareView(viewModel: viewModel)
            }

        case .error(let errorMessage):
            ChecksumCard {
                VStack(alignment: .leading, spacing: HashHawkLayout.contentSpacing) {
                    Label("mainContent.error.unableToRead", systemImage: "exclamationmark.triangle.fill")
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
