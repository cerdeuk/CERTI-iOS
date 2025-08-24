//
//  DefaultCareersRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

final class DefaultCareersRepository: CareersRepository {
    
    private let service: CareersServiceProtocol

    public init(service: CareersServiceProtocol) {
        self.service = service
    }
    
    func fetchCareersList() async -> Result<CareersListResponseDTO, NetworkError> {
        return await service.fetchCareersList()
    }
    
    func deledteCareers(id: Int) async -> Result<Void, NetworkError> {
        return await service.deledteCareers(id: id)
    }
    
    func addCareer(request: CareersEntity) async -> Result<Bool, NetworkError> {
        let requestDTO = request.toAddCareerRequestDTO()
        return await service.addCareer(request: requestDTO)
    }
}
