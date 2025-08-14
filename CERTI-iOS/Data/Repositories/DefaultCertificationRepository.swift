//
//  DefaultCertificationRepository.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

final class DefaultCertificationRepository: BaseService<CertificationAPI>, CertificationRepository {
        
    func getCategory(isFavorite: Bool, jobs: String)
    async -> Result<CategoryListResponseDTO, NetworkError> {
        return await requestDecodable(.fetchCategoryList(isFavorite: isFavorite, jobs: jobs))
    }
    
    func switchFavorite(certificationId: Int)
    async -> Result<Void, NetworkError> {
        return await requestVoid(.switchFavorite(certificationId: certificationId))
    }
    
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError> {
        return await requestDecodable(.searchCertification(keyword: keyword))
    }
    
    func fetchCertificationDetail(certificationId: Int)
    async -> Result<CertificationDetailResponseDTO, NetworkError> {
        return await requestDecodable(.fetchCertificationDetail(certificationId: certificationId))
    }
    
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError> {
        return await requestDecodable(.getRecommendCertification)
    }
}
