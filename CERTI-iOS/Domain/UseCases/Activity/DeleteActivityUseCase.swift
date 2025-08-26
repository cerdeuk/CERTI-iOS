//
//  DeleteActivityUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol DeleteActivityUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError>
}

final class DefaultDeleteActivityUseCase: DeleteActivityUseCase {
    private let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteActivity(id: id)
    }
}
