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
    func editJob(jobNameList: EditJobRequestDTO) async -> Result<Void, NetworkError>
}

final class JobService: BaseService, JobsServiceProtocol {
    private let provider = MoyaProvider<JobAPI>.init(plugins: [MoyaPlugin()])

    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchJob)
    }
    func editJob(jobNameList: EditJobRequestDTO) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .editJob(request: jobNameList))
    }
}
