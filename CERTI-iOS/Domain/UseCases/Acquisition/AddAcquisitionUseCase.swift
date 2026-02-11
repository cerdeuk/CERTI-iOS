//
//  AddAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

 protocol AddAcquisitionUseCase {
    func execute(request: AddAcquisitionEntity) async -> Result<Bool, NetworkError>
}

final class DefaultAddAcquisitionUseCase: AddAcquisitionUseCase {
    private let repository: AcquisitionRepository
    
    init(repository: AcquisitionRepository) {
        self.repository = repository
    }
    
    func execute(request: AddAcquisitionEntity) async -> Result<Bool, NetworkError> {
        let result = await repository.addAcquisition(request: request)
        return result
    }
}
