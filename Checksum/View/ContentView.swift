//
//  ContentView.swift
//  Checksum
//
//  Created by Hongyu Shi on 2024/11/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChecksumViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            DropZoneView(selectedFile: $viewModel.selectedFile) {
                viewModel.calculateHashes()
            }
            .frame(maxWidth: viewModel.isCalculating || viewModel.isFileSelected ? 200 : .infinity)
            .onTapGesture {
                selectFile()
            }
            
            if viewModel.isCalculating || viewModel.isFileSelected {
                HashResultView(viewModel: viewModel)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 744, minHeight: 292)
        .padding(8)
        .onDisappear {
            viewModel.cancelCalculation()
        }
    }
    
    private func selectFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        
        if panel.runModal() == .OK {
            viewModel.selectFile(panel.url!)
        }
    }
}

#Preview {
    ContentView()
}
