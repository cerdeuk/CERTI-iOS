//
//  FetchRecommendUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

protocol FetchRecommendUseCase {
    func execute() async -> Result<CertificationsEntity, NetworkError>
}

final class DefaultFetchRecommendUseCase: FetchRecommendUseCase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<CertificationsEntity, NetworkError> {
        return await repository.getRecommend()
    }
}

