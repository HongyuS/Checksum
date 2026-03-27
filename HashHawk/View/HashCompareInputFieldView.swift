//
//  HashCompareInputFieldView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import SwiftUI

struct HashCompareInputFieldView: View {
    @Binding var compareText: String
    let isFocused: FocusState<Bool>.Binding

    var body: some View {
        ZStack(alignment: .leading) {
            if compareText.isEmpty {
                Text("hash.compare.placeholder")
                    .font(.body.monospaced())
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal, 14)
                    .allowsHitTesting(false)
            }

            TextField("", text: $compareText)
                .textFieldStyle(.plain)
                .lineLimit(1)
                .font(.body.monospaced())
                .focused(isFocused)
                .accessibilityLabel(Text("hash.compare.placeholder"))
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
        }
        .frame(maxWidth: .infinity)
        .frame(height: HashHawkLayout.compareControlHeight)
        .glassEffect(.regular, in: .rect(cornerRadius: HashHawkLayout.fieldCornerRadius))
    }
}

#Preview("Compare Field • Placeholder") {
    @Previewable @State var compareText = ""
    @FocusState var isFocused: Bool

    HashCompareInputFieldView(compareText: $compareText, isFocused: $isFocused)
        .padding()
        .frame(width: 460)
        .preferredColorScheme(.light)
}

#Preview("Compare Field • Filled • Dark") {
    @Previewable @State var compareText = PreviewFixtures.partialHashInput
    @FocusState var isFocused: Bool

    HashCompareInputFieldView(compareText: $compareText, isFocused: $isFocused)
        .padding()
        .frame(width: 460)
        .preferredColorScheme(.dark)
}
