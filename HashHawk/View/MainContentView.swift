//
//  MainContentView.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import SwiftUI

struct MainContentView: View {
    @Bindable var viewModel: HashHawkViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let availableHeight = max(
                0,
                proxy.size.height - HashHawkLayout.detailTopInset - HashHawkLayout.outerPadding
            )

            VStack(spacing: HashHawkLayout.sectionSpacing) {
                if let selectedFile = viewModel.selectedFile {
                    SelectedFileInfoView(
                        selectedFile: selectedFile,
                        displayPath: viewModel.selectedFileDisplayPath,
                        fileIcon: viewModel.fileIcon,
                        formattedFileSize: viewModel.formattedFileSize,
                        isCalculating: viewModel.isCalculating
                    )
                }

                MainContentStateView(viewModel: viewModel)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: HashHawkLayout.contentWidth, maxHeight: .infinity, alignment: .top)
            .frame(height: availableHeight, alignment: .top)
            .padding(.top, HashHawkLayout.detailTopInset)
            .padding(.horizontal, HashHawkLayout.outerPadding)
            .padding(.bottom, HashHawkLayout.outerPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    MainContentView(viewModel: HashHawkViewModel())
}
