//
//  HashHawkTests.swift
//  HashHawkTests
//
//  Created by Hongyu Shi on 2024/11/7.
//

import Foundation
import Testing
@testable import HashHawk

struct HashHawkTests {

    @MainActor
    @Test func compareHashMatchesKnownDigest() {
        let viewModel = HashHawkViewModel()
        viewModel.hashResult = HashResult(
            md5: "md5-value",
            sha1: "sha1-value",
            sha256: "sha256-value",
            sha384: "sha384-value",
            sha512: "sha512-value"
        )
        
        viewModel.compareHash("  SHA256-VALUE  ")
        
        #expect(
            viewModel.comparisonResult == HashComparisonResult(
                inputHash: "sha256-value",
                matchedHash: "sha256-value",
                hashType: "SHA256",
                isMatch: true
            )
        )
    }
    
    @MainActor
    @Test func clearComparisonResetsInputAndResult() {
        let viewModel = HashHawkViewModel()
        viewModel.compareText = "abc"
        viewModel.comparisonResult = HashComparisonResult(
            inputHash: "abc",
            matchedHash: nil,
            hashType: nil,
            isMatch: false
        )
        
        viewModel.clearComparison()
        
        #expect(viewModel.compareText.isEmpty)
        #expect(viewModel.comparisonResult == nil)
    }
    
    @Test func hashTypeReturnsExpectedValue() {
        let result = HashResult(
            md5: "a",
            sha1: "b",
            sha256: "c",
            sha384: "d",
            sha512: "e"
        )
        
        #expect(HashType.sha384.value(from: result) == "d")
        #expect(HashType.sha512.value(from: result) == "e")
    }

    @MainActor
    @Test func selectFileRefreshesMetadataImmediately() throws {
        let fileURL = URL.temporaryDirectory.appending(path: "测试 文件 \(UUID().uuidString).txt")
        let fileContents = Data("checksum-test".utf8)
        try fileContents.write(to: fileURL)
        defer { try? FileManager.default.removeItem(at: fileURL) }

        let viewModel = HashHawkViewModel()
        viewModel.selectFile(fileURL)

        #expect(viewModel.selectedFile == fileURL.standardizedFileURL)
        #expect(viewModel.selectedFileDisplayPath == fileURL.path(percentEncoded: false))
        #expect(viewModel.fileSize == Int64(fileContents.count))
        #expect(!viewModel.formattedFileSize.isEmpty)
        #expect(viewModel.fileIcon != nil)

        viewModel.cancelCalculation()
    }
}
