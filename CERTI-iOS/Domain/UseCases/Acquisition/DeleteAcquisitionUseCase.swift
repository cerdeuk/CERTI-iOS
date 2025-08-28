//
//  DeleteAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

protocol DeleteAcquisitionUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError>
}

final class DefaultDeleteAcquisitionUseCase: DeleteAcquisitionUseCase {
    private let repository: AcquisitionRepository
    
    init(repository: AcquisitionRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteAcquisition(id: id)
    }
}
