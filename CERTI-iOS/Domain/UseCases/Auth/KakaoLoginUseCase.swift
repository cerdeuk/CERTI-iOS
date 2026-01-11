//
//  KakaoLoginUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

protocol KakaoLoginUseCase {
    func execute(type: String, accessToken: String) async -> Result<LoginResponseEntity, NetworkError>
}

final class DefaultKakaoLoginUseCase: KakaoLoginUseCase {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(type: String, accessToken: String) async -> Result<LoginResponseEntity, NetworkError> {
        return await repository.login(type: type, accessToken: accessToken)
    }
}
