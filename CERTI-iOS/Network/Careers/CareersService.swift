//
//  CareersService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya



final class CareersService: BaseService, CareersRepository {
    private let provider = MoyaProvider<CareersAPI>.init(plugins: [MoyaPlugin()])
    
    func fetchCareersList() async -> Result<CareersListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchCareersList)
    }
    
    func deledteCareers(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .deleteCareers(id: id))
    }
    
    func addCareer(request: AddCareerRequestDTO) async -> Result<Bool, NetworkError> {
        return await requestDecodable(provider, .addCareer(request: request))
    }
}
