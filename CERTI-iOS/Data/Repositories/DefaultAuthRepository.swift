//
//  DefaultAuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import Moya

final class DefaultAuthRepository: AuthRepository {
    
    private let service: AuthServiceProtocol

    public init(service: AuthServiceProtocol) {
        self.service = service
    }
        
    func withDraw() async -> Result<Void, NetworkError> {
        return await service.withDraw()
    }
    
    func signUp(request: SignupRequestDTO, preSignUpToken: String) async -> Result<SignupSuccessResponseDTO, NetworkError> {
        return await service.signUp(request: request, preSignUpToken: preSignUpToken)
    }
    
    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponse, NetworkError> {
        return await service.login(type: type, authorizationCode: authorizationCode)
    }
}
