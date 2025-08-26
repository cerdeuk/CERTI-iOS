//
//  AddActivityUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol AddActivityUseCase {
    func execute(request: ActivityEntity) async -> Result<Void, NetworkError>
}

final class DefaultAddActivityUseCase: AddActivityUseCase {
    private let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
    }
    
    func execute(request: ActivityEntity) async -> Result<Void, NetworkError> {
        return await repository.addActivity(request: request)
    }
}
