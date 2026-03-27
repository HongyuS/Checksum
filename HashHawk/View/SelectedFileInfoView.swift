//
//  SelectedFileInfoView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import SwiftUI

struct SelectedFileInfoView: View {
    let selectedFile: URL
    let displayPath: String
    let fileIcon: NSImage?
    let formattedFileSize: String
    let isCalculating: Bool
    
    @State private var isPathPopoverPresented = false
    
    var body: some View {
        ChecksumCard {
            HStack(alignment: .top, spacing: 18) {
                iconView
                
                VStack(alignment: .leading, spacing: 12) {
                    Button {
                        isPathPopoverPresented.toggle()
                    } label: {
                        HStack(spacing: 8) {
                            Text(selectedFile.lastPathComponent)
                                .font(.title3.weight(.semibold))
                                .lineLimit(1)
                                .truncationMode(.middle)
                            
                            Image(systemName: "info.bubble.fill")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(Text("selectedFile.showPath"))
                    .accessibilityValue(displayPath)
                    .popover(isPresented: $isPathPopoverPresented, arrowEdge: .top) {
                        pathPopover
                    }
                    
                    HStack(spacing: 10) {
                        metadataBadge(
                            title: formattedFileSize,
                            systemImage: "externaldrive"
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var pathPopover: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("selectedFile.path", systemImage: "folder")
                .font(.headline)
            
            Text(displayPath)
                .font(.callout.monospaced())
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .frame(minWidth: 320, idealWidth: 420, maxWidth: 520, alignment: .leading)
    }
    
    private var iconView: some View {
        Group {
            if let fileIcon {
                Image(nsImage: fileIcon)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "doc.fill")
                    .font(.system(size: 42, weight: .medium))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 56, height: 56)
        .accessibilityHidden(true)
    }
    
    private func metadataBadge(title: String, systemImage: String, tint: Color? = nil) -> some View {
        Label(title, systemImage: systemImage)
            .font(.subheadline)
            .foregroundStyle(tint ?? .secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .glassEffect(.regular, in: .capsule)
    }
}

#Preview("Selected File • Standard") {
    SelectedFileInfoView(
        selectedFile: PreviewFixtures.selectedFileURL,
        displayPath: PreviewFixtures.selectedFileDisplayPath,
        fileIcon: nil,
        formattedFileSize: PreviewFixtures.formattedFileSize,
        isCalculating: false
    )
    .padding()
    .frame(width: 560)
    .preferredColorScheme(.light)
}

#Preview("Selected File • Dark") {
    SelectedFileInfoView(
        selectedFile: PreviewFixtures.selectedFileURL,
        displayPath: PreviewFixtures.selectedFileDisplayPath,
        fileIcon: nil,
        formattedFileSize: PreviewFixtures.formattedFileSize,
        isCalculating: false
    )
    .padding()
    .frame(width: 560)
    .preferredColorScheme(.dark)
}
