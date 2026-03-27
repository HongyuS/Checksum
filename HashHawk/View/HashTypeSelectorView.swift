//
//  HashTypeSelectorView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import SwiftUI

struct HashTypeSelectorView: View {
    @Binding var selection: HashType
    @Namespace private var selectionNamespace

    var body: some View {
        ViewThatFits(in: .horizontal) {
            selectorBar

            ScrollView(.horizontal) {
                selectorBar
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
        .scrollIndicators(.hidden)
    }

    private var selectorBar: some View {
        HStack(spacing: 6) {
            ForEach(HashType.allCases) { hashType in
                Button {
                    withAnimation(.snappy(duration: 0.24, extraBounce: 0.08)) {
                        selection = hashType
                    }
                } label: {
                    Text(hashType.rawValue)
                        .font(.headline)
                        .foregroundStyle(selection == hashType ? .primary : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .contentShape(.capsule)
                        .background {
                            if selection == hashType {
                                Capsule()
                                    .fill(.clear)
                                    .matchedGeometryEffect(id: "selectedHashType", in: selectionNamespace)
                                    .glassEffect(
                                        .regular.tint(Color.accentColor.opacity(0.24)).interactive(),
                                        in: .capsule
                                    )
                            }
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel(AppLocalization.hashTypeSelectionAccessibilityLabel(hashType.rawValue))
            }
        }
        .padding(6)
        .background {
            Capsule()
                .fill(.clear)
                .glassEffect(.regular, in: .capsule)
        }
        .overlay {
            Capsule()
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        }
    }
}

#Preview {
    @Previewable @State var selection: HashType = .sha256

    HashTypeSelectorView(selection: $selection)
        .padding()
}