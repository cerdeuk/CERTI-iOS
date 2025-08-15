//
//  DefaultJobRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import Foundation

import Moya

final class DefaultJobRepository: JobRepository {
    
    private let service: JobsServiceProtocol

    public init(service: JobsServiceProtocol) {
        self.service = service
    }

    func getFetchJob() async -> Result<JobListResponseDTO, NetworkError> {
        return await requestDecodable(.fetchJob)
    }
    
    func editJob(jobNameList: [String]) async -> Result<Void, NetworkError> {
        let requestDTO = EditJobRequestDTO(jobNameList: jobNameList)
        return await requestVoid(.editJob(request: requestDTO))
    }
}
