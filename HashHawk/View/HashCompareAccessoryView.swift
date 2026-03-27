//
//  HashCompareAccessoryView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import SwiftUI

struct HashCompareAccessoryView: View {
    let comparisonResult: HashComparisonResult?
    let showsClearButton: Bool
    let clearAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            if let comparisonResult {
                ComparisonResultView(comparison: comparisonResult)
            }

            if showsClearButton {
                Button(action: clearAction) {
                    ZStack {
                        Circle()
                            .fill(.clear)

                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .frame(
                        width: HashHawkLayout.compareControlHeight,
                        height: HashHawkLayout.compareControlHeight
                    )
                    .contentShape(.circle)
                }
                .frame(
                    width: HashHawkLayout.compareControlHeight,
                    height: HashHawkLayout.compareControlHeight
                )
                .buttonStyle(.plain)
                .glassEffect(.regular.interactive(), in: .circle)
                .accessibilityLabel(Text("hash.compare.clear"))
            }
        }
        .frame(height: HashHawkLayout.compareControlHeight)
    }
}

#Preview {
    HashCompareAccessoryView(
        comparisonResult: HashComparisonResult(
            inputHash: "abc",
            matchedHash: "abc",
            hashType: "SHA256",
            isMatch: true
        ),
        showsClearButton: true,
        clearAction: {}
    )
    .padding()
}
