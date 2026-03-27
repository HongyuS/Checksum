//
//  HashRow.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct HashRow: View {
    let hash: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView(.horizontal) {
                Text(formattedHash)
                    .font(.body.monospaced())
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scrollIndicators(.hidden)
            
            HStack {
                Spacer()
                
                Button("hash.action.copy", systemImage: "doc.on.doc", action: copyHash)
                    .buttonStyle(.glass)
            }
        }
        .padding(16)
        .glassEffect(.regular, in: .rect(cornerRadius: HashHawkLayout.fieldCornerRadius))
    }
    
    private var formattedHash: String {
        var groupedHash = ""
        
        for (index, character) in hash.enumerated() {
            if index > 0 && index.isMultiple(of: 4) {
                groupedHash.append(" ")
            }
            groupedHash.append(character)
        }
        
        return groupedHash
    }
    
    private func copyHash() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(hash, forType: .string)
    }
}

#Preview("Hash Row • Short") {
    HashRow(hash: PreviewFixtures.partialHashInput)
        .padding()
        .frame(width: 420)
        .preferredColorScheme(.light)
}

#Preview("Hash Row • Long • Dark") {
    HashRow(hash: PreviewFixtures.sampleHashResult.sha512)
        .padding()
        .frame(width: 520)
        .preferredColorScheme(.dark)
}
