//
//  CareersService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

protocol CareersServiceProtocol {
    func fetchCareersList() async -> Result<CareersListResponseDTO, NetworkError>
}

final class CareersService: BaseService, CareersServiceProtocol {
    private let provider = MoyaProvider<CareersAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchCareersList() async -> Result<CareersListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchCareersList)
    }
}
