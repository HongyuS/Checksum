//
//  HashCompareFieldSectionView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import SwiftUI

struct HashCompareFieldSectionView: View {
    @Bindable var viewModel: HashHawkViewModel
    let isFocused: FocusState<Bool>.Binding

    var body: some View {
        HashCompareInputFieldView(
            compareText: $viewModel.compareText,
            isFocused: isFocused
        )
        .onChange(of: viewModel.compareText) { _, newValue in
            viewModel.compareHash(newValue)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = HashHawkViewModel()
    @FocusState var isFocused: Bool

    HashCompareFieldSectionView(viewModel: viewModel, isFocused: $isFocused)
        .padding()
}
