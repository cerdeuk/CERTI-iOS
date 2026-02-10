//
//  UpdateEditProfileInfoUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

protocol UpdateEditProfileInfoUseCase {
    func execute(info: EditProfileEntity) async -> Result<Void, NetworkError>
}

final class DefaultUpdateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(info: EditProfileEntity) async -> Result<Void, NetworkError> {
        return await repository.putEditProfileInfo(profileInfo: info)
    }
}
