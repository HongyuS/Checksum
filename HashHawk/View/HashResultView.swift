//
//  HashResultView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/14.
//

import SwiftUI

struct HashResultView: View {
    let result: HashResult
    
    @State private var selectedHashType: HashType = .md5
    
    var body: some View {
        ChecksumCard {
            VStack(alignment: .leading, spacing: HashHawkLayout.contentSpacing) {
                HashTypeSelectorView(selection: $selectedHashType)
                
                HashRow(hash: selectedHashType.value(from: result))
            }
        }
    }
}

#Preview("Hash Result • Default") {
    HashResultView(result: PreviewFixtures.sampleHashResult)
        .padding()
        .frame(width: 620)
        .preferredColorScheme(.light)
}

#Preview("Hash Result • Compact • Dark") {
    HashResultView(result: PreviewFixtures.sampleHashResult)
        .padding()
        .frame(width: 360)
        .preferredColorScheme(.dark)
}
