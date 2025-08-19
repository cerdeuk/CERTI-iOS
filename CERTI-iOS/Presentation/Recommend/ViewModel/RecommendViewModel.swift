//
//  RecommendViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

import os

@MainActor
class RecommendViewModel: ObservableObject {
    
    var username: String = AuthManager.shared.nickname
    
    @Published var licenseCards: [LicenseCardModel] = []
    @Published var isFilterModalPresented = false
    @Published var selectedCategories: [String] = []
    @Published var selectedCertificateId: Int = 0
    
    private let recommendService = AppDIContainer.shared.makeCertificationRepository()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Recommend")
    
    private let jobService = AppDIContainer.shared.makeJobRepository()

    @Published var isShowLoading: Bool = false
    
    var interestTags: [String] {
        selectedCategories.map(\.description)
    }
    
    func toggleFavorite(id: Int) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
    
    func selectCertificate(id: Int) {
        selectedCertificateId = id
    }
    
    func toggleLoadingState() {
        isShowLoading.toggle()
    }
}


//MARK: - Network

extension RecommendViewModel {
    func getRecommendCertificationList() async {
        let result = await recommendService.getRecommend()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")
            
            let list = response.data?.recommendationList.map { $0.toLicenseCardModel() } ?? []
            licenseCards = list
            
        case .failure(let error):
            logger.error("❌ 추천 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func postFavorite(certificationId: Int) async {
        let result = await recommendService.switchFavorite(certificationId: certificationId)
        
        switch result {
        case .success(_):
            logger.debug("✅ toggleFavorite success")
            
        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")
        }
    }
    
    func getJobList() async {
        let result = await jobService.getFetchJob()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getJobList: No data received")
                return
            }
            
            self.selectedCategories = data.jobList
            logger.debug("✅ getJobList success: \(data.jobList)")
            
        case .failure(let error):
            logger.error("getJobList failed: \(error.localizedDescription)")
        }
    }
    
    func postJobList(jobNameList: [String]) async {
        let result = await jobService.editJob(jobNameList: selectedCategories)
        
        switch result {
        case .success(_):
            logger.debug("✅ editJob: No data success")
            
        case .failure(let error):
            logger.error("editJob failed: \(error.localizedDescription)")
        }
    }
}
