//
//  FetchMyPageUnivListUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/26/26.
//

import Foundation

protocol FetchMyPageUnivListUseCase {
    func execute(keyword: String) async -> Result<UniversityListEntity, NetworkError>
}

final class DefaultFetchMyPageUnivListUseCase: FetchMyPageUnivListUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(keyword: String) async -> Result<UniversityListEntity, NetworkError> {
        await repository.getSearchUniv(keyword: keyword)
    }
    
}
