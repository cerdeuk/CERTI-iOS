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
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError>
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError>
    func addPreCertification(request: AddPreCertificationRequestDTO) async -> Result<BaseResponseDTO<Bool>, NetworkError>
    
}

final class HomeService: BaseService, HomeServiceProtocol {
            
    private let provider = MoyaProvider<HomeAPI>.init(plugins: [MoyaPlugin()])

    func getPreCertification() async -> Result<PreCertificationInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getPreCertification)
    }
    
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deletePreCertification(id: id))
    }
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getFavoriteCertification)
    }

    func addPreCertification(request: AddPreCertificationRequestDTO) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(provider, .addPreCertification(request: request))
    }
}
