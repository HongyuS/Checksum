//
//  AppLocalization.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

import Foundation

enum AppLocalization {
    static func fileSelectionFailed(_ description: String) -> String {
        String.localizedStringWithFormat(
            String(localized: "error.fileSelectionFailed"),
            description
        )
    }

    static func unableToReadFile(_ filename: String, description: String) -> String {
        String.localizedStringWithFormat(
            String(localized: "error.unableToReadFile"),
            filename,
            description
        )
    }

    static func hashTypeSelectionAccessibilityLabel(_ hashType: String) -> String {
        String.localizedStringWithFormat(
            String(localized: "hashType.select"),
            hashType
        )
    }

    static func comparisonAccessibilityLabel(isMatch: Bool, hashType: String?) -> String {
        if let hashType {
            return String.localizedStringWithFormat(
                String(localized: isMatch ? "comparison.accessibility.matchWithType" : "comparison.accessibility.mismatchWithType"),
                hashType
            )
        }

        return String(localized: isMatch ? "comparison.accessibility.match" : "comparison.accessibility.mismatch")
    }
}