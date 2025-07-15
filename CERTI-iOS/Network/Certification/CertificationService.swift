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
    
    func toggleFavorite(certificationId: Int)
        async -> Result<EmptyResponseDTO, NetworkError>
}

final class CertificationService: BaseService, CertificationServiceProtocol {
    
    private let provider = MoyaProvider<CertificationAPI>.init(plugins: [MoyaPlugin()])
    
    func getCategory(isFavorite: Bool, jobs: String)
        async -> Result<CategoryListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .viewCategoryList(isFavorite: isFavorite, jobs: jobs))
    }
    
    func toggleFavorite(certificationId: Int)
        async -> Result<EmptyResponseDTO, NetworkError> {
        return await requestDecodable(provider, .toggleFavorite(certificationId: certificationId))
    }
}
