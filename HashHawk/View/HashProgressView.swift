//
//  HashProgressView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct HashProgressView: View {
    let progress: Double
    let message: LocalizedStringKey
    
    var body: some View {
        ChecksumCard {
            VStack(alignment: .leading, spacing: HashHawkLayout.contentSpacing) {
                HStack {
                    Text(progress, format: .percent.precision(.fractionLength(0)))
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                    
                    Spacer()
                    
                    Label("hash.progress.calculating", systemImage: "cpu")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .glassEffect(.regular.tint(Color.orange.opacity(0.22)).interactive(), in: .capsule)
                }
                
                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("Progress • Midway") {
    HashProgressView(progress: 0.42, message: "mainContent.calculating.message")
        .padding()
        .frame(width: 480)
        .preferredColorScheme(.light)
}

#Preview("Progress • Nearly Done • Dark") {
    HashProgressView(progress: 0.92, message: "mainContent.calculating.message")
        .padding()
        .frame(width: 480)
        .preferredColorScheme(.dark)
}
