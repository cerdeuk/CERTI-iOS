//
//  CheckNickNameUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/10/26.
//

import Foundation

protocol CheckNickNameUseCase {
    func execute(nickname: String) async -> Result<String, NetworkError>
}

final class DefaultCheckNickNameUseCase: CheckNickNameUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(nickname: String) async -> Result<String, NetworkError> {
        return await repository.checkNickName(nickname: nickname)
    }
}
