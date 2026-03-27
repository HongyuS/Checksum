//
//  PreviewFixtures.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import Foundation

@MainActor
enum PreviewFixtures {
    static let selectedFileURL = URL(fileURLWithPath: "/Users/demo/Desktop/HashHawk-Preview.dmg")
    static let selectedFileDisplayPath = "/Users/demo/Desktop/HashHawk-Preview.dmg"
    static let formattedFileSize = "1.2 GB"
    static let sampleHashResult = HashResult(
        md5: "d41d8cd98f00b204e9800998ecf8427e",
        sha1: "da39a3ee5e6b4b0d3255bfef95601890afd80709",
        sha256: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
        sha384: "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b",
        sha512: "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"
    )
    static let matchedComparison = HashComparisonResult(
        inputHash: sampleHashResult.sha256,
        matchedHash: sampleHashResult.sha256,
        hashType: HashType.sha256.rawValue,
        isMatch: true
    )
    static let mismatchedComparison = HashComparisonResult(
        inputHash: "deadbeefdeadbeefdeadbeefdeadbeef",
        matchedHash: nil,
        hashType: nil,
        isMatch: false
    )
    static let partialHashInput = String(sampleHashResult.sha256.prefix(16))
    static let sampleErrorMessage = "Preview failed to read the selected file because the file is currently unavailable."

    static func makeIdleViewModel(fileSelected: Bool = false) -> HashHawkViewModel {
        let viewModel = HashHawkViewModel()

        if fileSelected {
            populateSelectedFile(on: viewModel)
        }

        return viewModel
    }

    static func makeCalculatingViewModel(progress: Double = 0.42) -> HashHawkViewModel {
        let viewModel = makeIdleViewModel(fileSelected: true)
        viewModel.isCalculating = true
        viewModel.progress = progress
        return viewModel
    }

    static func makeResultViewModel(
        compareText: String = "",
        comparisonResult: HashComparisonResult? = nil
    ) -> HashHawkViewModel {
        let viewModel = makeIdleViewModel(fileSelected: true)
        viewModel.hashResult = sampleHashResult
        viewModel.compareText = compareText
        viewModel.comparisonResult = comparisonResult
        return viewModel
    }

    static func makeErrorViewModel() -> HashHawkViewModel {
        let viewModel = makeIdleViewModel(fileSelected: true)
        viewModel.errorMessage = sampleErrorMessage
        return viewModel
    }

    private static func populateSelectedFile(on viewModel: HashHawkViewModel) {
        viewModel.selectedFile = selectedFileURL
        viewModel.selectedFileDisplayPath = selectedFileDisplayPath
        viewModel.selectedFileSize = 1_288_490_189
        viewModel.fileIcon = nil
    }
}
