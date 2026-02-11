//
//  AcquisitionService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya

protocol AcquisitionServiceProtocol {
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError>
    func addAcquisition(request: AddAcquisitionRequestDTO) async -> Result<BaseResponseDTO<Bool>, NetworkError>
    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailResponseDTO, NetworkError>
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError>
}

final class AcquisitionService: BaseService, AcquisitionServiceProtocol {
    private let provider = MoyaProvider<AcquisitionAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchAcquisitionList)
    }

    func addAcquisition(request: AddAcquisitionRequestDTO) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(provider, .addAcquisition(request: request))
    }

    func fetchAcquisitionDetail(id: Int) async -> Result<AcquisitionDetailResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchAcquisitionDetail(id: id))
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteAcquisition(id: id))
    }
}
