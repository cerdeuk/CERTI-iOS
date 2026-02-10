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
    
    func fetchActivityList() async -> Result<ActivityListEntity, NetworkError> {
        let result = await service.fetchActivityList()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toActivityListEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteActivity(id: Int) async -> Result<Void, NetworkError> {
        return await service.deleteActivity(id: id)
    }
    
    func addActivity(request: ActivityEntity) async -> Result<Void, NetworkError> {
        let requestDTO = request.toAddActivityRequestDTO()
        return await service.addActivity(request: requestDTO)
    }
    
    func editActivity(activityId: Int, request: ActivityEntity) async -> Result<Void, NetworkError> {
        let requestDTO = request.toEditActivityRequestDTO()
        return await service.editActivity(activityId: activityId, request: requestDTO)
    }
}
