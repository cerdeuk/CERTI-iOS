//
//  SignUpUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

protocol SignUpUseCase {
    func execute(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupResponseEntity, NetworkError>
}

final class DefaultSignUpUseCase: SignUpUseCase {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupResponseEntity, NetworkError> {
        return await repository.signUp(request: request, preSignUpToken: preSignUpToken)
    }
}
