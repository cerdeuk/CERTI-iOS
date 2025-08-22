//
//  LoginUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

protocol LoginUseCase {
    func execute(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponseEntity, NetworkError>
}

final class DefaultLoginUseCase: LoginUseCase {
    
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponseEntity, NetworkError> {
        await repository.login(type: type, authorizationCode: authorizationCode)
    }
    
}
