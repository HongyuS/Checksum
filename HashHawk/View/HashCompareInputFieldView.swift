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
                Text("输入或粘贴哈希值…")
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
                .padding(.horizontal, 14)
                .padding(.vertical, 11)
        }
        .frame(maxWidth: .infinity)
        .frame(height: HashHawkLayout.compareControlHeight)
        .glassEffect(.regular, in: .rect(cornerRadius: HashHawkLayout.fieldCornerRadius))
    }
}

#Preview {
    @Previewable @State var compareText = "abcdef123456"
    @FocusState var isFocused: Bool

    HashCompareInputFieldView(compareText: $compareText, isFocused: $isFocused)
        .padding()
}
