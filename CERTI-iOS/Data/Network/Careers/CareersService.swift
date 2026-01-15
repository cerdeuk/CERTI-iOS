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
    func deledteCareers(id: Int) async -> Result<Void, NetworkError>
    func addCareer(request: AddCareerRequestDTO) async -> Result<Bool, NetworkError>
    func editCareer(request: EditCareerRequestDTO) async -> Result<Bool, NetworkError>
}

final class CareersService: BaseService, CareersServiceProtocol {
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
    
    func editCareer(request: EditCareerRequestDTO) async -> Result<Bool, NetworkError> {
        return await requestDecodable(provider, .editCareer(request: request))
    }
}
