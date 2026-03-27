//
//  ContentView.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var viewModel = HashHawkViewModel()
    @State private var isFileImporterPresented = false
    
    var body: some View {
        NavigationSplitView {
            DropZoneView(
                hasSelectedFile: viewModel.isFileSelected,
                openFilePicker: openFilePicker,
                handleDroppedFile: viewModel.selectFile
            )
            .navigationSplitViewColumnWidth(
                min: HashHawkLayout.sidebarMinWidth,
                ideal: HashHawkLayout.sidebarIdealWidth,
                max: HashHawkLayout.sidebarMaxWidth
            )
        } detail: {
            MainContentView(viewModel: viewModel)
        }
        .navigationSplitViewStyle(.balanced)
        .frame(
            minWidth: HashHawkLayout.windowMinWidth,
            minHeight: HashHawkLayout.windowMinHeight
        )
        .fileImporter(
            isPresented: $isFileImporterPresented,
            allowedContentTypes: [.item],
            allowsMultipleSelection: false,
            onCompletion: handleFileImport
        )
        .onDisappear(perform: viewModel.cancelCalculation)
    }

    private func openFilePicker() {
        isFileImporterPresented = true
    }
    
    private func handleFileImport(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let selectedURL = urls.first else { return }
            viewModel.selectFile(selectedURL)
        case .failure(let error):
            let nsError = error as NSError
            guard nsError.code != NSUserCancelledError else { return }
            viewModel.errorMessage = "文件选择失败：\(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
