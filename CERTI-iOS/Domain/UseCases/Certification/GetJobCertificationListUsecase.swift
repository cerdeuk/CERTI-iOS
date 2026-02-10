//
//  GetJobCertificationListUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

protocol GetJobCertificationListUsecase {
    func execute(job: String) async -> Result<CertificationListEntity, NetworkError>
}

final class DefaultGetJobCertificationListUsecase: GetJobCertificationListUsecase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(job: String) async -> Result<CertificationListEntity, NetworkError> {
        return await repository.getJobCertificationList(job: job)
    }
}

