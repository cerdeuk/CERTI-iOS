//
//  FetchCertificationDetailUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

protocol FetchCertificationDetailUseCase {
    func execute(id: Int) async -> Result<CertificationDetailEntity, NetworkError>
}

final class DefaultFetchCertificationDetailUseCase: FetchCertificationDetailUseCase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<CertificationDetailEntity, NetworkError> {
        return await repository.fetchCertificationDetail(certificationId: id)
    }
}
