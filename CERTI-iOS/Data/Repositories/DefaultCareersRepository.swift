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
    
    func fetchCareersList() async -> Result<CareersListEntity, NetworkError> {
        let result = await service.fetchCareersList()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCareersListEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deleteCareers(id: Int) async -> Result<Void, NetworkError> {
        return await service.deledteCareers(id: id)
    }
    
    func addCareer(request: CareersEntity) async -> Result<Bool, NetworkError> {
        let requestDTO = request.toAddCareerRequestDTO()
        return await service.addCareer(request: requestDTO)
    }
    
    func editCareer(request: CareersEntity) async -> Result<Bool, NetworkError> {
        let requestDTO = request.toEditCareerRequestDTO()
        return await service.editCareer(request: requestDTO)
    }
}
