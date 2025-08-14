//
//  DefaultCareersRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

final class DefaultCareersRepository: BaseService<CareersAPI>, CareersRepository {
    
    func fetchCareersList() async -> Result<CareersListResponseDTO, NetworkError> {
        return await requestDecodable(.fetchCareersList)
    }
    
    func deledteCareers(id: Int) async -> Result<Void, NetworkError> {
        return await requestVoid(.deleteCareers(id: id))
    }
    
    func addCareer(request: AddCareerRequestDTO) async -> Result<Bool, NetworkError> {
        return await requestDecodable(.addCareer(request: request))
    }
}
