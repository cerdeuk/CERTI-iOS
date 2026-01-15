//
//  EditCareersUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/15/26.
//

import Foundation

protocol EditCareersUseCase {
    func execute(request: CareersEntity) async -> Result<Bool, NetworkError>
}

final class DefaultEditCareersUseCase: EditCareersUseCase {
    private let repository: CareersRepository
    
    init(repository: CareersRepository) {
        self.repository = repository
    }
    
    func execute(request: CareersEntity) async -> Result<Bool, NetworkError> {
        return await repository.editCareer(request: request)
    }
}
