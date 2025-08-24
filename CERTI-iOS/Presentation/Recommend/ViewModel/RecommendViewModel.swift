//
//  RecommendViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

import os

struct RecommendStateModel {
    var licenseCards: [LicenseCardModel] = []
    var selectedCategories: [String] = []
    var isFilterModalPresented = false
    var isShowLoading: Bool = false
}

@MainActor
class RecommendViewModel: ObservableObject {
    @Published var recommendStateModel = RecommendStateModel()
    @Published var selectedCertificateId: Int = 0
    
    var username: String = AuthManager.shared.nickname

    var interestTags: [String] {
        recommendStateModel.selectedCategories.map(\.description)
    }
    
    func toggleFavorite(id: Int) {
        guard let index = recommendStateModel.licenseCards.firstIndex(where: { $0.id == id }) else { return }
        recommendStateModel.licenseCards[index].isFavorite.toggle()
    }
    
    func selectCertificate(id: Int) {
        selectedCertificateId = id
    }
    
    func toggleLoadingState() {
        recommendStateModel.isShowLoading.toggle()
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Recommend")
    
    private let fetchRecommendUseCase: FetchRecommendUseCase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let fetchJobUseCase: FetchJobUseCase
    private let editJobUseCase: EditJobUseCase
    
    init(
        fetchRecommendUseCase: FetchRecommendUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchJobUseCase: FetchJobUseCase,
        editJobUseCase: EditJobUseCase
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchJobUseCase = fetchJobUseCase
        self.editJobUseCase = editJobUseCase
    }
}


//MARK: - Network

extension RecommendViewModel {
    func getRecommendCertificationList() async {
        let result = await fetchRecommendUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")
            
            self.recommendStateModel.licenseCards = response.toLicenseCardModelList()
            
        case .failure(let error):
            logger.error("❌ 추천 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func postFavorite(certificationId: Int) async {
        let result = await switchFavoriteUseCase.execute(id: certificationId)
        
        switch result {
        case .success(_):
            logger.debug("✅ toggleFavorite success")
            
        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")
        }
    }
    
    func getJobList() async {
        let result = await fetchJobUseCase.execute()
        
        switch result {
        case .success(let response):
            
            self.recommendStateModel.selectedCategories = response.jobs
            logger.debug("✅ getJobList success: \(response.jobs)")
            
        case .failure(let error):
            logger.error("getJobList failed: \(error.localizedDescription)")
        }
    }
    
    func postJobList(jobNameList: [String]) async {
        let jobs = JobEntity(jobs: jobNameList)
        let result = await editJobUseCase.execute(jobNameList: jobs)
        
        switch result {
        case .success(_):
            logger.debug("✅ editJob: No data success")
            
        case .failure(let error):
            logger.error("editJob failed: \(error.localizedDescription)")
        }
    }
}
