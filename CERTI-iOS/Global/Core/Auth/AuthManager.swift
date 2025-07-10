//
//  AuthManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import os

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Auth")
    private let keychain = KeychainManager.shared    
    
}
