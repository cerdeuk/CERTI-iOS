//
//  HomeViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import os

// 뷰모델 사용 예시를 보여주기 위한 임시 모델
struct HomeStateModel {
    var username: String = ""
    var userUniversity: String = ""
    var userDepartment: String = ""
    var progressValue: Int = 0
    
    var recommendLicenses: [RecommendLicenseCardModel] = []
    var preLicenses: [PreLicenseCardModel] = []
    var favoriteLicenses: [FavoriteLicenseCardModel] = []
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var homeStateModel = HomeStateModel()
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "WithDraw")
}


//MARK: - Network

extension HomeViewModel {
    func withDraw() async {
        let result = await NetworkService.shared.authService.withDraw()
        
        switch result {
        case .success:
            logger.info("✅ 탈퇴 성공")
            AuthManager.shared.cleanUserInfo()
            
        case .failure(let error):
            logger.error("❌ 탈퇴 실패: \(error.localizedDescription)")
        }
    }
    
    func getUserInfo() async {
        let result = await NetworkService.shared.userService.getuserInfo()
        
        switch result {
        case .success(let response):
            logger.info("✅ 유저 정보 조회 성공")
            homeStateModel.username = response.data?.name ?? ""
            homeStateModel.userUniversity = response.data?.university ?? ""
            homeStateModel.userDepartment = response.data?.major ?? ""
            homeStateModel.progressValue = response.data?.percentage ?? 0
            
        case .failure(let error):
            logger.error("❌ 탈퇴 실패: \(error.localizedDescription)")
        }
    }
    
    func getRecommendCertificationList() async {
        let result = await NetworkService.shared.certificationService.getRecommend()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")

            let list = response.data?.recommendationList.map { $0.toRecommendLicenseCardModel() } ?? []
            homeStateModel.recommendLicenses = list
            
        case .failure(let error):
            logger.error("❌ 추천 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func getPreCertificationList() async {
        let result = await NetworkService.shared.homeService.getPreCertification()
        
        switch result {
        case .success(let response):
            logger.info("✅ 취득 예정 자격증 조회 성공")

            let list = response.data?.toPreLicenseCardModelList()
            
            homeStateModel.preLicenses = list ?? []
            
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
}
