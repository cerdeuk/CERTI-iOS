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
    
    func fetchCareersList() async -> Result<CareerListEntity, NetworkError> {
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
    
    func addCareer(request: CareerEntity) async -> Result<Void, NetworkError> {
        let requestDTO = request.toAddCareerRequestDTO()
        return await service.addCareer(request: requestDTO)
    }
    
    func editCareer(careerId: Int, request: CareerEntity) async -> Result<Void, NetworkError> {
        let requestDTO = request.toEditCareerRequestDTO()
        return await service.editCareer(careerId: careerId, request: requestDTO)
    }
}
