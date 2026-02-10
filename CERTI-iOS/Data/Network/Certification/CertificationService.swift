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
    func switchFavorite(certificationId: Int) async -> Result<Void, NetworkError>
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError>
    func fetchCertificationDetail(certificationId: Int) async -> Result<CertificationDetailResponseDTO, NetworkError>
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError>
    func getTrackRankCertification() async -> Result<RankCertificationResponseDTO, NetworkError>
    func getJobRankCertification() async -> Result<RankCertificationResponseDTO, NetworkError>
    func getJobCertificationList(job: String) async -> Result<CertificationListResponseDTO, NetworkError>
    func getTrackCertificationList(track: String) async -> Result<CertificationListResponseDTO, NetworkError>

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
    
    func fetchCertificationDetail(certificationId: Int)
    async -> Result<CertificationDetailResponseDTO, NetworkError> {
        return await requestDecodable(provider, .fetchCertificationDetail(certificationId: certificationId))
    }
    
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getRecommendCertification)
    }
    
    func getTrackRankCertification() async -> Result<RankCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getTrackRankCertification)
    }
    
    func getJobRankCertification() async -> Result<RankCertificationResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getJobRankCertification)
    }
    
    func getJobCertificationList(job: String) async -> Result<CertificationListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getJobCertificationList(job: job))
    }
    
    func getTrackCertificationList(track: String) async -> Result<CertificationListResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getTrackCertificationList(track: track))
    }
}
