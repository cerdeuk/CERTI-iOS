//
//  DefaultHomeRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

enum AppendPreCertificationStatus: Equatable {
    case conflictError        // 상태코드 409
    case duplicationError     // data == false
    case success        // data == true
}

final class DefaultHomeRepository: HomeRepository {
    private let service: HomeServiceProtocol

    public init(service: HomeServiceProtocol) {
        self.service = service
    }

    func getPreCertification() async -> Result<PreCertificationEntity, NetworkError> {
        let result = await service.getPreCertification()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toPreCertificationEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func deletePreCertification(id: Int) async -> Result<Void, NetworkError> {
        return await service.deletePreCertification(id: id)
    }
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationEntity, NetworkError> {
        let result = await service.getFavoriteCertification()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toFavoriteCertificationEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }

    func addPreCertification(request: AddPreCertificationEntity) async -> Result<AppendPreCertificationStatus, NetworkError> {
        let dto = request.toAddPreCertificationRequestDTO()
        let result = await service.addPreCertification(request: dto)
        switch result {
        case .success(let response):
            if response.status == 409 {
                return .success(.conflictError)
            }
            guard let data = response.data else {
                return .failure(.decodingError)
            }
            if data {
                return .success(.success)
            } else {
                return .success(.duplicationError)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func editPreCertification(request: EditPreCertificationEntity, id: Int) async -> Result<Void, NetworkError> {
        let dto = EditPreCertificationRequestDTO(testDate: request.testDate, city: request.city, state: request.state)
        return await service.editPreCertification(request: dto, id: id)
    }
}
