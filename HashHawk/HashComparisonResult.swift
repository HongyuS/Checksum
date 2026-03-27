//
//  HashComparisonResult.swift
//  HashHawk
//
//  Created by Hongyu Shi on 2025/09/24.
//

import Foundation

struct HashComparisonResult: Equatable, Sendable {
    let inputHash: String
    let matchedHash: String?
    let hashType: String?
    let isMatch: Bool
}
