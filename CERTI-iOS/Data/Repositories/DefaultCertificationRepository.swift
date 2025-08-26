//
//  DefaultCertificationRepository.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

final class DefaultCertificationRepository: CertificationRepository {
        
    private let service: CertificationServiceProtocol

    public init(service: CertificationServiceProtocol) {
        self.service = service
    }
    
    func getCategory(isFavorite: Bool, jobs: String)
    async -> Result<CertificationsEntity, NetworkError> {
        let result = await service.getCategory(isFavorite: isFavorite, jobs: jobs)
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCertificationsEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func switchFavorite(certificationId: Int)
    async -> Result<Void, NetworkError> {
        return await service.switchFavorite(certificationId: certificationId)
    }
    
    func searchCertification(keyword: String) async -> Result<CertificationsEntity, NetworkError> {
        let result = await service.searchCertification(keyword: keyword)
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCertificationsEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchCertificationDetail(certificationId: Int)
    async -> Result<CertificationDetailEntity, NetworkError> {
        let result = await service.fetchCertificationDetail(certificationId: certificationId)
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCertificationDetailEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getRecommend() async -> Result<CertificationsEntity, NetworkError> {
        let result = await service.getRecommend()
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toCertificationsEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
}
