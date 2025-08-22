//
//  FetchAcquisitionListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

protocol FetchAcquisitionListUseCase {
    func execute() async -> Result<AcquisitionListEntity, NetworkError>
}

final class DefaultFetchAcquisitionListUseCase: FetchAcquisitionListUseCase {
    private let repository: AcquisitionRepository
    
    init(repository: AcquisitionRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<AcquisitionListEntity, NetworkError> {
        return await repository.fetchAcquisitionList()
    }
    
    
}
