//
//  CertificationService.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

protocol CertificationServiceProtocol {
    func getCategory(isFavorite: Bool, jobs: String) async -> Result<CategoryListResponseDTO, NetworkError>
    func fetchFavorite(certificationId: Int) async -> Result<Void, NetworkError>
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError>
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError>
}

final class CertificationService: BaseService, CertificationServiceProtocol {
    
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

    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getRecommendCertification)
    }
}
