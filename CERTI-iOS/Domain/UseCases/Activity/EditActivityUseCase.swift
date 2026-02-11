//
//  EditActivityUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

protocol EditActivityUseCase {
    func execute(activityId:Int, request: ActivityEntity) async -> Result<Void, NetworkError>
}

final class DefaultEditActivityUseCase: EditActivityUseCase {
    private let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
    }
    
    func execute(activityId: Int, request: ActivityEntity) async -> Result<Void, NetworkError> {
        return await repository.editActivity(activityId: activityId, request: request)
    }
}
