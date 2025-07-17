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
}

final class AcquisitionService: BaseService, AcquisitionServiceProtocol {
    private let provider = MoyaProvider<AcquisitionAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchAcquisitionList() async -> Result<AcquisitionListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchAcquisitionList)
    }
}
