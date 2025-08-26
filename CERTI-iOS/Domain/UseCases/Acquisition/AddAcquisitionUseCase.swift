//
//  AddAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

 protocol AddAcquisitionUseCase {
    func execute(certificationId: Int) async -> Result<Bool, NetworkError>
}

final class DefaultAddAcquisitionUseCase: AddAcquisitionUseCase {
    private let repository: AcquisitionRepository
    
    init(repository: AcquisitionRepository) {
        self.repository = repository
    }
    
    func execute(certificationId: Int) async -> Result<Bool, NetworkError> {
        let result = await repository.addAcquisition(certificationId: certificationId)
        return result.map { $0.data ?? false }
    }
}
