//
//  AcquisitionService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya



final class AcquisitionService: BaseService, AcquisitionRepository {
    private let provider = MoyaProvider<AcquisitionAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchAcquisitionList)
    }

    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(provider, .addAcquisition(certificationId: certificationId))
    }

    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchAcquisitionDetail(id: id))
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteAcquisition(id: id))
    }
}
