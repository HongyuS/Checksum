//
//  HashProgressView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct HashProgressView: View {
    let progress: Double
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(.linear)
                .frame(height: 8)
            
            Text(message)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("\(Int(progress * 100))%")
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    HashProgressView(progress: 0.4, message: "正在计算校验和...")
}
