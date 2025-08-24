//
//  AddCareers.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol AddCareersUseCase {
    func excute(request: CareersEntity) async -> Result<Bool, NetworkError>
}

final class DefaultAddCareersUseCase: AddCareersUseCase {
    private let repository: CareersRepository
    
    init(repository: CareersRepository) {
        self.repository = repository
    }
    
    func excute(request: CareersEntity) async -> Result<Bool, NetworkError> {
        return await repository.addCareer(request: request)
    }
}
