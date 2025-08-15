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
    async -> Result<CategoryListResponseDTO, NetworkError> {
        return await service.getCategory(isFavorite: isFavorite, jobs: jobs)
    }
    
    func switchFavorite(certificationId: Int)
    async -> Result<Void, NetworkError> {
        return await service.switchFavorite(certificationId: certificationId)
    }
    
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError> {
        return await service.searchCertification(keyword: keyword)
    }
    
    func fetchCertificationDetail(certificationId: Int)
    async -> Result<CertificationDetailResponseDTO, NetworkError> {
        return await service.fetchCertificationDetail(certificationId: certificationId)
    }
    
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError> {
        return await service.getRecommend()
    }
}
