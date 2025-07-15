//
//  HomeService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

protocol HomeServiceProtocol {
    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError>
}

final class HomeService: BaseService, HomeServiceProtocol {
    
    private let provider = MoyaProvider<HomeAPI>.init(plugins: [MoyaPlugin()])

    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getPreCertification)
    }
    
}
