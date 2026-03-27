//
//  ComparisonResultView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import SwiftUI

struct ComparisonResultView: View {
    let comparison: HashComparisonResult
    
    @Environment(\.accessibilityReduceMotion) private var accessibilityReduceMotion
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: comparison.isMatch ? "checkmark.circle.fill" : "xmark.circle.fill")

            if let hashType = comparison.hashType {
                Text(hashType)
                    .fontWeight(.semibold)
            }
        }
        .font(.subheadline)
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .frame(height: HashHawkLayout.compareControlHeight)
        .foregroundStyle(tintColor)
        .glassEffect(.regular.tint(tintColor.opacity(0.24)).interactive(), in: .capsule)
        .animation(
            accessibilityReduceMotion ? .easeInOut(duration: 0.15) : .smooth,
            value: comparison.isMatch
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }
    
    private var tintColor: Color {
        comparison.isMatch ? .green : .red
    }
    
    private var accessibilityLabel: String {
        AppLocalization.comparisonAccessibilityLabel(
            isMatch: comparison.isMatch,
            hashType: comparison.hashType
        )
    }
}