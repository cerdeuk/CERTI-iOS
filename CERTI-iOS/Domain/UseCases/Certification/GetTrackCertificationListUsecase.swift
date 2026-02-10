//
//  GetTrackCertificationListUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

protocol GetTrackCertificationListUsecase {
    func execute(track: String) async -> Result<CertificationListEntity, NetworkError>
}

final class DefaultGetTrackCertificationListUsecase: GetTrackCertificationListUsecase {
    private let repository: CertificationRepository

    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(track: String) async -> Result<CertificationListEntity, NetworkError> {
        return await repository.getTrackCertificationList(track: track)
    }
}

