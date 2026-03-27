//
//  HashProgressView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct HashProgressView: View {
    let progress: Double
    let message: String
    
    var body: some View {
        ChecksumCard {
            VStack(alignment: .leading, spacing: HashHawkLayout.contentSpacing) {
                HStack {
                    Text(progress, format: .percent.precision(.fractionLength(0)))
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .monospacedDigit()

                    Spacer()

                    Label("计算中", systemImage: "cpu")
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

#Preview {
    HashProgressView(progress: 0.4, message: "正在生成 MD5、SHA1、SHA256、SHA384 和 SHA512…")
}
