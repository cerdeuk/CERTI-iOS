//
//  FetchMyPageMajorListUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/26/26.
//

import Foundation

protocol FetchMyPageMajorListUseCase {
    func execute(keyword: String) async -> Result<MajorListEntity, NetworkError>
}

final class DefaultFetchMyPageMajorListUseCase: FetchMyPageMajorListUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(keyword: String) async -> Result<MajorListEntity, NetworkError> {
        await repository.getSearchMajor(keyword: keyword)
    }
}
