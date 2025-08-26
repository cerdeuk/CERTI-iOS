//
//  FetchCategoryUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

protocol FetchCategoryUseCase {
    func execute(isFavorite: Bool, jobs: String) async -> Result<CertificationsEntity, NetworkError>
}

final class DefaultFetchCategoryUseCase: FetchCategoryUseCase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(isFavorite: Bool, jobs: String) async -> Result<CertificationsEntity, NetworkError> {
        return await repository.getCategory(isFavorite: isFavorite, jobs: jobs)
    }
}

