//
//  DeleteCareersUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol DeleteCareersUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError>
}

final class DefaultDeleteCareersUseCase: DeleteCareersUseCase {
    private let repository: CareersRepository
    
    init(repository: CareersRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteCareers(id: id)
    }
}
