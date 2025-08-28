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

    func getFetchJob() async -> Result<JobEntity, NetworkError> {
        let result = await service.getFetchJob()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toJobEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func editJob(jobNameList: JobEntity) async -> Result<Void, NetworkError> {
        let requestDTO = jobNameList.toEditJobRequestDTO()
        return await service.editJob(jobNameList: requestDTO)
    }
}
