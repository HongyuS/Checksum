//
//  DropZoneView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropZoneView: View {
    @Binding var selectedFile: URL?
    var onDrop: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .foregroundStyle(.blue)
                .frame(height: 150)
            
            VStack(spacing: 12) {
                Image(systemName: "arrow.down.doc")
                    .font(.system(size: 30))
                Text("拖放文件到这里")
                    .font(.headline)
                Text("或点击选择文件")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onDrop(of: [.fileURL], isTargeted: nil) { providers in
            guard let provider = providers.first else { return false }
            
            provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier) { (urlData, error) in
                guard let urlData = urlData as? Data,
                      let path = String(data: urlData, encoding: .utf8),
                      let url = URL(string: path) else { return }
                
                DispatchQueue.main.async {
                    selectedFile = url
                    onDrop()
                }
            }
            return true
        }
    }
}
