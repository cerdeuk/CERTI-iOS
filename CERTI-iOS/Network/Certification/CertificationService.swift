//
//  CertificationService.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

protocol CertificationServiceProtocol {
    func getCategory(isFavorite: Bool, jobs: String)
        async -> Result<CategoryListResponseDTO, NetworkError>
    
    func fetchFavorite(certificationId: Int)
        async -> Result<EmptyResponseDTO, NetworkError>
}

final class CertificationService: BaseService, CertificationServiceProtocol {
    
    private let provider = MoyaProvider<CertificationAPI>.init(plugins: [MoyaPlugin()])
    
    func getCategory(isFavorite: Bool, jobs: String)
        async -> Result<CategoryListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .viewCategoryList(isFavorite: isFavorite, jobs: jobs))
    }
    
    func fetchFavorite(certificationId: Int)
        async -> Result<EmptyResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchFavorite(certificationId: certificationId))
    }
}
