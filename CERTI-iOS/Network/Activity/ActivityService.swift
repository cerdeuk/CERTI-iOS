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
    func addActivity(request: AddActivityRequestDTO) async -> Result<Bool, NetworkError>
}

final class ActivityService: BaseService, ActivityServiceProtocol {
    private let provider = MoyaProvider<ActivityAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchActivityList() async -> Result<ActivityListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchActivityList)
    }
    
    func addActivity(request: AddActivityRequestDTO) async -> Result<Bool, NetworkError> {
        return await requestDecodable(provider, .addActivity(request: request))
    }
}
