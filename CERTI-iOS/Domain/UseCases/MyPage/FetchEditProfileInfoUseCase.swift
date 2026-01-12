//
//  FetchEditProfileInfoUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

protocol FetchEditProfileInfoUseCase {
    func execute() async -> Result<EditProfileEntity, NetworkError>
}

final class DefaultFetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<EditProfileEntity, NetworkError> {
        let result = await repository.getEditProfileInfo()
        return result
    }
}
