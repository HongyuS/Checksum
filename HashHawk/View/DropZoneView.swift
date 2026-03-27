//
//  DropZoneView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct DropZoneView: View {
    let hasSelectedFile: Bool
    let openFilePicker: () -> Void
    let handleDroppedFile: (URL) -> Void
    
    @State private var isTargeted = false
    
    var body: some View {
        ZStack {
            Color.clear

            VStack(spacing: 18) {
                Image(systemName: promptSymbol)
                    .font(.system(size: 58, weight: .semibold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(isTargeted ? Color.accentColor : .secondary)

                VStack(spacing: 10) {
                    Text(promptTitle)
                        .font(.title2.weight(.semibold))

                    Text(promptSubtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 220)
                }
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .toolbar(removing: .sidebarToggle)
        .toolbar {
            ToolbarSpacer(.flexible)

            ToolbarItem {
                openFileButton
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .inset(by: 8)
                .strokeBorder(
                    isTargeted ? Color.accentColor.opacity(0.7) : .clear,
                    style: StrokeStyle(lineWidth: 2, dash: [10, 6])
                )
        }
        .dropDestination(for: URL.self) { items, _ in
            guard let droppedFile = items.first else { return false }
            handleDroppedFile(droppedFile)
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
    }

    private var openFileButton: some View {
        Button(
            openFileButtonTitle,
            systemImage: "folder",
            action: openFilePicker
        )
    }

    private var openFileButtonTitle: LocalizedStringKey {
        hasSelectedFile ? "dropZone.button.replace" : "dropZone.button.open"
    }

    private var promptTitle: LocalizedStringKey {
        isTargeted ? "dropZone.prompt.title.release" : "dropZone.prompt.title.drop"
    }

    private var promptSubtitle: LocalizedStringKey {
        if isTargeted {
            "dropZone.prompt.subtitle.release"
        } else if hasSelectedFile {
            "dropZone.prompt.subtitle.replace"
        } else {
            "dropZone.prompt.subtitle.open"
        }
    }

    private var promptSymbol: String {
        isTargeted ? "square.and.arrow.down.on.square.fill" : "square.and.arrow.down.on.square"
    }
}
