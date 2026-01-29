//
//  CertificationRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation

protocol CertificationRepository {
    func getCategory(isFavorite: Bool, jobs: String) async -> Result<CertificationsEntity, NetworkError>
    func switchFavorite(certificationId: Int) async -> Result<Void, NetworkError>
    func searchCertification(keyword: String) async -> Result<CertificationsEntity, NetworkError>
    func fetchCertificationDetail(certificationId: Int) async -> Result<CertificationDetailEntity, NetworkError>
    func getRecommend() async -> Result<CertificationsEntity, NetworkError>
    func getTrackRankCertification() async -> Result<[RankCertificationEntity], NetworkError>
    func getJobRankCertification() async -> Result<[RankCertificationEntity], NetworkError>
}


