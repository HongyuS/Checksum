//
//  HashCompareView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2025/09/24.
//

import SwiftUI

struct HashCompareView: View {
    @Bindable var viewModel: HashHawkViewModel
    @FocusState private var isCompareFieldFocused: Bool
    
    var body: some View {
        ChecksumCard {
            HStack(spacing: 12) {
                HashCompareFieldSectionView(
                    viewModel: viewModel,
                    isFocused: $isCompareFieldFocused
                )
                
                if showsAccessoryContent {
                    HashCompareAccessoryView(
                        comparisonResult: viewModel.comparisonResult,
                        showsClearButton: !viewModel.compareText.isEmpty,
                        clearAction: clearCompareField
                    )
                }
            }
        }
    }
    
    private var showsAccessoryContent: Bool {
        viewModel.comparisonResult != nil || !viewModel.compareText.isEmpty
    }
    
    private func clearCompareField() {
        viewModel.clearComparison()
        isCompareFieldFocused = false
    }
}

#Preview("Compare • Match") {
    HashCompareView(
        viewModel: PreviewFixtures.makeResultViewModel(
            compareText: PreviewFixtures.sampleHashResult.sha256,
            comparisonResult: PreviewFixtures.matchedComparison
        )
    )
    .padding()
    .frame(width: 620)
    .preferredColorScheme(.light)
}

#Preview("Compare • Mismatch") {
    HashCompareView(
        viewModel: PreviewFixtures.makeResultViewModel(
            compareText: PreviewFixtures.mismatchedComparison.inputHash,
            comparisonResult: PreviewFixtures.mismatchedComparison
        )
    )
    .padding()
    .frame(width: 620)
    .preferredColorScheme(.light)
}

#Preview("Compare • Typing • Dark") {
    HashCompareView(
        viewModel: PreviewFixtures.makeResultViewModel(
            compareText: PreviewFixtures.partialHashInput
        )
    )
    .padding()
    .frame(width: 620)
    .preferredColorScheme(.dark)
}
