//
//  ActivityService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

protocol ActivityServiceProtocol {
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError>
    func deleteActivity(id: Int) async -> Result<Void, NetworkError>
}

final class ActivityService: BaseService, ActivityServiceProtocol {
    private let provider = MoyaProvider<ActivityAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchActivityList)
    }
    
    func deleteActivity(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteActivity(id: id))
    }
}
