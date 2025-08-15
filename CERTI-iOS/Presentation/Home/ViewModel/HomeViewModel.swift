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
    @Published var selectedLicenseId: Int = 0
    
    func toggleFavorite(id: Int) {
        guard let index = homeStateModel.favoriteLicenses.firstIndex(where: { $0.certificationId == id }) else { return }
        homeStateModel.favoriteLicenses[index].isFavorite.toggle()
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "HOME")
    
    private let authRepository = AppDIContainer.shared.makeAuthRepository()
    private let userRepository = AppDIContainer.shared.makeUserRepository()
    private let certificationRepository = AppDIContainer.shared.makeCertificationRepository()
    private let homeRepository = AppDIContainer.shared.makeHomeRepository()
    
    private let homeUseCase: HomeUseCase

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
}


//MARK: - Network

extension HomeViewModel {
    func withDraw() async {
        let result = await authRepository.withDraw()

        switch result {
        case .success:
            logger.info("✅ 탈퇴 성공")
            AuthManager.shared.cleanUserInfo()
            
        case .failure(let error):
            logger.error("❌ 탈퇴 실패: \(error.localizedDescription)")
        }
    }
    
    func getUserInfo() async {
        let result = await userRepository.getuserInfo()
        
        switch result {
        case .success(let response):
            logger.info("✅ 유저 정보 조회 성공")
            homeStateModel.username = response.data?.name ?? ""
            homeStateModel.userUniversity = response.data?.university ?? ""
            homeStateModel.userDepartment = response.data?.major ?? ""
            homeStateModel.progressValue = response.data?.percentage ?? 0
            AuthManager.shared.nickname = response.data?.name ?? ""
            
        case .failure(let error):
            logger.error("❌ 탈퇴 실패: \(error.localizedDescription)")
        }
    }
    
    func getRecommendCertificationList() async {
        let result = await certificationRepository.getRecommend()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")
            
            let list = response.data?.recommendationList.map { $0.toRecommendLicenseCardModel() } ?? []
            homeStateModel.recommendLicenses = list
            
        case .failure(let error):
            logger.error("❌ 추천 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchPreCertification() async {
        let result = await homeUseCase.getPreCertification()
        
        switch result {
        case .success(let models):
            logger.info("✅ 취득 예정 자격증 조회 성공")

            self.homeStateModel.preLicenses = models.toModels()
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func deletePreCertification(id: Int) async {
        let result = await homeRepository.deletePreCertification(id: id)
        
        switch result {
        case .success:
            logger.info("✅ 취득 예정 자격증 삭제 성공")
            homeStateModel.preLicenses.removeAll { $0.certificationId == id }
            
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 삭제 실패: \(error.localizedDescription)")
            
        }
    }
    
    func getFavoriteCertificationList() async {
        let result = await homeUseCase.getFavoriteCertification()
                
        switch result {
        case .success(let response):
            logger.info("✅ 즐겨찾기 자격증 조회 성공")
            
            let list = response.toModels()
            homeStateModel.favoriteLicenses = list
            
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 삭제 실패: \(error.localizedDescription)")
            
        }
    }
    
    func toggleFavoriteCertification(certificationId: Int) async {
        let result = await certificationRepository.switchFavorite(certificationId: certificationId)
        
        switch result {
        case .success():
            logger.debug("✅ toggleFavorite success")

        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")

        }
    }
    
}
