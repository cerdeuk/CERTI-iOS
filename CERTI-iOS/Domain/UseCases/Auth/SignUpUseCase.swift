//
//  SignUpUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

protocol SignUpUseCase {
    func execute(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupSuccessUserDataEntity, NetworkError>
}

final class DefaultSignUpUseCase: SignUpUseCase {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupSuccessUserDataEntity, NetworkError> {
        await repository.signUp(request: request, preSignUpToken: preSignUpToken)
    }
}
