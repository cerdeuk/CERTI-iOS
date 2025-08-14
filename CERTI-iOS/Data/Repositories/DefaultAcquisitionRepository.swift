//
//  DefaultAcquisitionRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya

final class DefaultAcquisitionRepository: BaseService<AcquisitionAPI>, AcquisitionRepository {
    
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError> {
        return await requestDecodable(.fetchAcquisitionList)
    }

    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(.addAcquisition(certificationId: certificationId))
    }

    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailResponseDTO, NetworkError> {
        return await requestDecodable(.fetchAcquisitionDetail(id: id))
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(.deleteAcquisition(id: id))
    }
}
