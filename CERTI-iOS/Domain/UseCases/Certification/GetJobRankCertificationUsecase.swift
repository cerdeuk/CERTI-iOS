//
//  GetJobRankCertificationUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

protocol GetJobRankCertificationUsecase {
    func execute() async -> Result<[RankCertificationEntity], NetworkError>
}

final class DefaultGetJobRankCertificationUsecase: GetJobRankCertificationUsecase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[RankCertificationEntity], NetworkError> {
        return await repository.getJobRankCertification()
    }
}

