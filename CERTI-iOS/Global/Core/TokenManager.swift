//
//  TokenManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

final class TokenManager {
    
    static let shared = TokenManager()
    private let keychain = KeychainManager.shared

    private init() {}

    func saveTokens(accessToken: String, refreshToken: String) -> Result<Void, AuthError> {
        switch keychain.save(accessToken, for: .accessToken) {
        case .success:
            switch keychain.save(refreshToken, for: .refreshToken) {
            case .success:
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    func updateAccessToken(_ token: String) -> Result<Void, AuthError> {
        return keychain.save(token, for: .accessToken)
    }

    func updateRefreshToken(_ token: String) -> Result<Void, AuthError> {
        return keychain.save(token, for: .refreshToken)
    }

    func getAccessToken() -> Result<String, AuthError> {
        return keychain.load(for: .accessToken)
    }

    func getRefreshToken() -> Result<String, AuthError> {
        return keychain.load(for: .refreshToken)
    }

    func clearTokens() -> Result<Void, AuthError> {
        return keychain.clearAll()
    }
}
