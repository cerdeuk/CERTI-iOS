//
//  fetchAcquisitionDetailUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

protocol FetchAcquisitionDetailUseCase {
    func excute(id: Int) async -> Result<AcquisitionDetailEntity, NetworkError>
}

final class DefaultFetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase {
    private let repository: AcquisitionRepository
    
    init(repository: AcquisitionRepository) {
        self.repository = repository
    }
    func excute() async -> Result<AcquisitionDetailEntity, NetworkError> {
        return await repository.fetchAcquisitionDetail(id: id)
    }
}
