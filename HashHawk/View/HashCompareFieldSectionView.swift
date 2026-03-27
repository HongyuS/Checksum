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

#Preview("Compare Section • Empty") {
    @Previewable @State var viewModel = PreviewFixtures.makeResultViewModel()
    @FocusState var isFocused: Bool

    HashCompareFieldSectionView(viewModel: viewModel, isFocused: $isFocused)
        .padding()
        .frame(width: 480)
        .preferredColorScheme(.light)
}

#Preview("Compare Section • Typing • Dark") {
    @Previewable @State var viewModel = PreviewFixtures.makeResultViewModel(
        compareText: PreviewFixtures.partialHashInput
    )
    @FocusState var isFocused: Bool

    HashCompareFieldSectionView(viewModel: viewModel, isFocused: $isFocused)
        .padding()
        .frame(width: 480)
        .preferredColorScheme(.dark)
}
