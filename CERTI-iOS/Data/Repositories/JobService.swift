//
//  JobService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import Foundation

import Moya

final class JobService: BaseService, JobRepository {
    private let provider = MoyaProvider<JobAPI>.init(plugins: [MoyaPlugin()])

    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchJob)
    }
    func editJob(jobNameList: [String]) async -> Result<Void, NetworkError> {
        let requestDTO = EditJobRequestDTO(jobNameList: jobNameList)
        return await requestVoid(provider, .editJob(request: requestDTO))
    }
}
