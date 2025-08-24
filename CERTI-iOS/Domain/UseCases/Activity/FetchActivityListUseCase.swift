//
//  FetchActivityListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

protocol FetchActivityListUseCase {
    func execute() async -> Result<ActivityDetailEntity, NetworkError>
}

final class DefaultFetchActivityListUseCase: FetchActivityListUseCase {
    private let repository: ActivityRepository
    
    init(repository: ActivityRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<ActivityDetailEntity, NetworkError> {
        return await repository.fetchActivityList()
    }
}
