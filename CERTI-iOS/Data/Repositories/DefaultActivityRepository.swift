//
//  DefaultActivityRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

final class DefaultActivityRepository: ActivityRepository {
    
    private let service: ActivityServiceProtocol

    public init(service: ActivityServiceProtocol) {
        self.service = service
    }
    
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError> {
        return await service.fetchActivityList()
    }
    
    func deleteActivity(id: Int) async -> Result<Void, NetworkError> {
        return await service.deleteActivity(id: id)
    }
    
    func addActivity(request: AddActivityRequestDTO) async -> Result<Void, NetworkError> {
        return await service.addActivity(request: request)
    }
}
