//
//  HashType.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/26.
//

import Foundation

enum HashType: String, CaseIterable, Identifiable {
    case md5 = "MD5"
    case sha1 = "SHA1"
    case sha256 = "SHA256"
    case sha384 = "SHA384"
    case sha512 = "SHA512"
    
    var id: String { rawValue }
    
    func value(from result: HashResult) -> String {
        switch self {
        case .md5:
            result.md5
        case .sha1:
            result.sha1
        case .sha256:
            result.sha256
        case .sha384:
            result.sha384
        case .sha512:
            result.sha512
        }
    }
}