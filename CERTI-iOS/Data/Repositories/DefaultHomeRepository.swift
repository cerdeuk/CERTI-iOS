//
//  DefaultHomeRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

final class DefaultHomeRepository: HomeRepository {
    
    private let service: HomeServiceProtocol

    public init(service: HomeServiceProtocol) {
        self.service = service
    }

    func getPreCertification() async -> Result<PreCertificationEntity, NetworkError> {
        let result = await service.getPreCertification()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toEntity() else {
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
    
    func getFavoriteCertification() async -> Result<FavoriteCertificationResponseDTO, NetworkError> {
        return await service.getFavoriteCertification()
    }

    func addPreCertification(certificationId: Int) async -> Result<BaseResponseDTO<Bool>, NetworkError> {
        return await service.addPreCertification(certificationId: certificationId)
    }
}
