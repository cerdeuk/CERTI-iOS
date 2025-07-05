//
//  KeychainManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

enum KeychainType: String, CaseIterable {
    case accessToken
    case refreshToken
}

final class KeychainManager {
    
    static let shared = KeychainManager()
    private init() {}
    
    func save(_ value: String, for key: KeychainType) -> Result<Void, AuthError> {
        let data = Data(value.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status: OSStatus
        
        if SecItemCopyMatching(query as CFDictionary, nil) == errSecSuccess {
            status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        } else {
            var newItem = query
            newItem[kSecValueData as String] = data
            status = SecItemAdd(newItem as CFDictionary, nil)
        }
        
        return status == errSecSuccess ? .success(()) : .failure(.keychainError)
    }
    
    func load(for key: KeychainType) -> Result<String, AuthError> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return .failure(.tokenNotFound)
        }
        
        return .success(value)
    }
    
    func delete(for key: KeychainType) -> Result<Void, AuthError> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return (status == errSecSuccess || status == errSecItemNotFound) ? .success(()) : .failure(.keychainError)
    }
    
    func clearAll() -> Result<Void, AuthError> {
        for key in KeychainType.allCases {
            if case .failure(let error) = delete(for: key) {
                return .failure(error)
            }
        }
        return .success(())
    }
}
