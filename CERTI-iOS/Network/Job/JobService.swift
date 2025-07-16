//
//  JobService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import Foundation

import Moya

protocol JobsServiceProtocol {
    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError>
}

final class JobService: BaseService, JobsServiceProtocol {
    private let provider = MoyaProvider<JobAPI>.init(plugins: [MoyaPlugin()])

    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchJob)
    }
}
