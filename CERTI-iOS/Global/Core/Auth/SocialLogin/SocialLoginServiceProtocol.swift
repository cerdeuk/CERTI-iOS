//
//  SocialLoginServiceProtocol.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

protocol SocialLoginServiceProtocol {
    func login() async -> Result<String, AuthError>
    func logout() async -> Result<Void, AuthError>
    func getServiceName() -> String
}
