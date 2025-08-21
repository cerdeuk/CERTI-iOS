//
//  FetchUserInfoUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

protocol FetchUserInfoUseCase {
    func execute() async -> Result<UserInfoEntity, NetworkError>
}

final class DefaultFetchUserInfoUseCase: FetchUserInfoUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<UserInfoEntity, NetworkError> {
        return await repository.getUserInfo()
    }
    
}
