//
//  DefaultAcquisitionRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya

final class DefaultAcquisitionRepository: AcquisitionRepository {
    
    private let service: AcquisitionServiceProtocol

    public init(service: AcquisitionServiceProtocol) {
        self.service = service
    }
    
    func fetchAcquisitionList() async -> Result<AcquisitionListEntity, NetworkError> {
        let result = await service.fetchAcquisitionList()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toAcquisitionListEntityList() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }

    func addAcquisition(certificationId: Int) async -> Result<Bool, NetworkError> {
        let result = await service.addAcquisition(certificationId: certificationId)
        switch result {
        case .success(let response):
            guard let response = response.data else {
                return .failure(.decodingError)
            }
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailEntity, NetworkError> {
        let result = await service.fetchAcquisitionDetail(id: id)
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toAcquisitionDetailEntityList() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError> {
        return await service.deleteAcquisition(id: id)
    }
}
