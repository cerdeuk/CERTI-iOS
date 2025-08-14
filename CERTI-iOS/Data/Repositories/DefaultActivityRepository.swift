//
//  DefaultActivityRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

final class DefaultActivityRepository: BaseService<ActivityAPI>, ActivityRepository {
    
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError> {
        return await requestDecodable(.fetchActivityList)
    }
    
    func deleteActivity(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(.deleteActivity(id: id))
    }
    
    func addActivity(request: AddActivityRequestDTO) async -> Result<Void, NetworkError> {
        return await requestVoid(.addActivity(request: request))
    }
}
