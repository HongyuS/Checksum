//
//  HashRow.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct HashRow: View {
    let title: String
    let hash: String
    
    private var formattedHash: String {
        var result = ""
        for (index, char) in hash.enumerated() {
            if index > 0 && index % 4 == 0 {
                result += " "
            }
            result.append(char)
        }
        return result
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(formattedHash)
                        .foregroundStyle(.secondary)
                        .font(.system(.body, design: .monospaced))
                        .textSelection(.enabled)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Button(action: {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(hash, forType: .string)
            }) {
                Image(systemName: "doc.on.doc")
                    .font(.system(.title2))
                    .padding(8)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    HashRow(title: "HASH", hash: "abcdef1234567890")
}
