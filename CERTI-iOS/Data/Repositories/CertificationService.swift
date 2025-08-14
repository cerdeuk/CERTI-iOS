//
//  CertificationService.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

final class CertificationService: BaseService, CertificationRepository {
    
    private let provider = MoyaProvider<CertificationAPI>.init(plugins: [MoyaPlugin()])
    
    func getCategory(isFavorite: Bool, jobs: String)
    async -> Result<CategoryListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchCategoryList(isFavorite: isFavorite, jobs: jobs))
    }
    
    func switchFavorite(certificationId: Int)
    async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .switchFavorite(certificationId: certificationId))
    }
    
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .searchCertification(keyword: keyword))
    }
    
    func fetchCertificationDetail(certificationId: Int)
    async -> Result<CertificationDetailResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchCertificationDetail(certificationId: certificationId))
    }
    
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getRecommendCertification)
    }
}
