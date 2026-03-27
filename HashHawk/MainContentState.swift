//
//  MainContentState.swift
//  HashHawk
//
//  Created by GitHub Copilot on 2026/3/27.
//

enum MainContentState {
    case idle
    case calculating
    case result(HashResult)
    case error(String)
}
