//
//  ActivityService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

final class ActivityService: BaseService, ActivityRepository {
    private let provider = MoyaProvider<ActivityAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchActivityList)
    }
    
    func deleteActivity(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteActivity(id: id))
    }
    
    func addActivity(request: AddActivityRequestDTO) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .addActivity(request: request))
    }
}
