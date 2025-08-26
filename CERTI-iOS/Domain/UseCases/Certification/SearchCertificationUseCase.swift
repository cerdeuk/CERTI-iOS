//
//  SearchCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

protocol SearchCertificationUseCase {
    func execute(keyword: String) async -> Result<CertificationsEntity, NetworkError>
}

final class DefaultSearchCertificationUseCase: SearchCertificationUseCase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(keyword: String) async -> Result<CertificationsEntity, NetworkError> {
        return await repository.searchCertification(keyword: keyword)
    }
}

