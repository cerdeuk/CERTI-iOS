//
//  Acquisition2Service.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/17/25.
//

import Foundation

import Moya

protocol Acquisition2ServiceProtocol {
    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError>
}

final class Acquisition2Service: BaseService, Acquisition2ServiceProtocol {
    
    private let provider = MoyaProvider<Acquisition2API>.init(plugins: [MoyaPlugin()])
    
    func addAcquisition(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await requestDecodable(provider, .addAcquisition(certificationId: certificationId))
    }
}

