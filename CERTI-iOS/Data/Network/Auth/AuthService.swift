//
//  AuthService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import Moya

protocol AuthServiceProtocol {
    func login(type: String, accessToken: String) async -> Result<LoginResponseDTO, NetworkError>
    func signUp(request: SignupRequestDTO, preSignUpToken: String) async -> Result<SignupResponseDTO, NetworkError>
    func withDraw() async -> Result<Void, NetworkError>
}

final class AuthService: BaseService, AuthServiceProtocol {

    private let provider = MoyaProvider<AuthAPI>.init(plugins: [MoyaPlugin()])
    
    func withDraw() async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .withDraw)
    }
    
    func signUp(request: SignupRequestDTO, preSignUpToken: String) async -> Result<SignupResponseDTO, NetworkError> {
        return await requestDecodable(provider, .signUp(request: request, preSignUpToken: preSignUpToken))
    }
    
    func login(type: String, accessToken: String) async -> Result<LoginResponseDTO, NetworkError> {
        return await requestDecodable(provider, .login(type: type, accessToken: accessToken))
    }
}
