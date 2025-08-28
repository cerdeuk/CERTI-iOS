//
//  FetchCareersListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol FetchCareersListUseCase {
    func execute() async -> Result<CareersListEntity, NetworkError>
}

final class DefaultFetchCareersListUseCase: FetchCareersListUseCase {
    private let repository: CareersRepository
    
    init(repository: CareersRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<CareersListEntity, NetworkError> {
        return await repository.fetchCareersList()
    }
}
