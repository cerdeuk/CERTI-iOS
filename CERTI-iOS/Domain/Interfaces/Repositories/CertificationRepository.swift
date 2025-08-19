//
//  CertificationRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation

protocol CertificationRepository {
    func getCategory(isFavorite: Bool, jobs: String) async -> Result<CategoryListResponseDTO, NetworkError>
    func switchFavorite(certificationId: Int) async -> Result<Void, NetworkError>
    func searchCertification(keyword: String) async -> Result<SearchCertificationResponseDTO, NetworkError>
    func fetchCertificationDetail(certificationId: Int) async -> Result<CertificationDetailResponseDTO, NetworkError>
    func getRecommend() async -> Result<RecommendCertificationResponseDTO, NetworkError>
}


