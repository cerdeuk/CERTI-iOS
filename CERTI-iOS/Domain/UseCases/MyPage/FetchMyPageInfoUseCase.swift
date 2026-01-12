//
//  FetchMyPageInfoUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import Foundation

protocol FetchMyPageInfoUseCase {
    func execute() async -> Result<MyPageEntity, NetworkError>
}

final class DefaultFetchMyPageInfoUseCase: FetchMyPageInfoUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<MyPageEntity, NetworkError> {
        let result = await repository.getMyPageInfo()
        return result
    }
}
