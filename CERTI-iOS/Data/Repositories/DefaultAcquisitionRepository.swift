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
    
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError> {
        return await service.fetchAcquisitionList()
    }

    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await service.addAcquisition(certificationId: certificationId)
    }

    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailResponseDTO, NetworkError> {
        return await service.fetchAcquisitionDetail(id: id)
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError> {
        return await service.deleteAcquisition(id: id)
    }
}
