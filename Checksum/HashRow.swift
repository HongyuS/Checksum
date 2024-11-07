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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            HStack {
                Text(hash)
                    .font(.system(.body, design: .monospaced))
                    .textSelection(.enabled)
                
                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(hash, forType: .string)
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    HashRow(title: "File", hash: "example-hash")
}
