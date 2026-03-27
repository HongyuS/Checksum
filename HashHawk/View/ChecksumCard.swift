//
//  ChecksumCard.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import SwiftUI

struct ChecksumCard<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .padding(HashHawkLayout.outerPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.regularMaterial, in: .rect(cornerRadius: HashHawkLayout.cardCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: HashHawkLayout.cardCornerRadius)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.08), radius: 18, y: 10)
    }
}

#Preview("Card • Light") {
    ChecksumCard {
        VStack(alignment: .leading, spacing: 8) {
            Text("Preview")
                .font(.headline)

            Text("Use this card to group hash results and actions.")
                .foregroundStyle(.secondary)
        }
    }
    .padding()
    .frame(width: 360)
}

#Preview("Card • Dark") {
    ChecksumCard {
        VStack(alignment: .leading, spacing: 8) {
            Text("Preview")
                .font(.headline)

            Text("Use this card to group hash results and actions.")
                .foregroundStyle(.secondary)
        }
    }
    .padding()
    .frame(width: 360)
    .preferredColorScheme(.dark)
}
