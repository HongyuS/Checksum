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

#Preview("State • Idle") {
    MainContentStateView(viewModel: PreviewFixtures.makeIdleViewModel())
        .padding()
        .frame(width: 520)
        .preferredColorScheme(.light)
}

#Preview("State • Calculating") {
    MainContentStateView(viewModel: PreviewFixtures.makeCalculatingViewModel())
        .padding()
        .frame(width: 520)
        .preferredColorScheme(.light)
}

#Preview("State • Result") {
    MainContentStateView(
        viewModel: PreviewFixtures.makeResultViewModel(
            compareText: PreviewFixtures.sampleHashResult.sha256,
            comparisonResult: PreviewFixtures.matchedComparison
        )
    )
    .padding()
    .frame(width: 520)
    .preferredColorScheme(.light)
}

#Preview("State • Error • Dark") {
    MainContentStateView(viewModel: PreviewFixtures.makeErrorViewModel())
        .padding()
        .frame(width: 520)
        .preferredColorScheme(.dark)
}
