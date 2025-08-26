//
//  RecommendViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

import os

enum RecommendViewRoute {
    case navigateToCertificateDetail
    
    case recommendViewRoutePop
}

@MainActor
class RecommendViewModel: ObservableObject {
    @Published var recommendViewRoute: RecommendViewRoute?
    @Published var licenseCards: [LicenseCardModel] = []
    @Published var selectedJobField: [String] = []
    @Published var isFilterModalPresented = false
    @Published var selectedCertificateId: Int = 0
    @Published var isShowLoading: Bool = false
    
    var username: String = AuthManager.shared.nickname

    var interestTags: [String] {
        selectedJobField.map(\.description)
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


// MARK: - Navigation Func

extension RecommendViewModel {
    
    func navigateToCertificateDetail() {
        recommendViewRoute = .navigateToCertificateDetail
    }
    
    func recommendViewRoutePop() {
        recommendViewRoute = .recommendViewRoutePop
    }
}


//MARK: - Network

extension RecommendViewModel {
    
    func getRecommendCertificationList() async {
        let result = await fetchRecommendUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")
            
            self.licenseCards = response.toLicenseCardModelList()
            
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
            
            self.selectedJobField = response.toJobFieldModel().jobList
            logger.debug("✅ getJobList success: \(response.jobs)")
            
        case .failure(let error):
            logger.error("getJobList failed: \(error.localizedDescription)")
        }
    }
    
    func postJobList(jobNameList: [String]) async {
        let result = await editJobUseCase.execute(jobNameList: JobFieldModel(jobList: jobNameList).toJobEntity())
        
        switch result {
        case .success(_):
            logger.debug("✅ editJob: No data success")
            
        case .failure(let error):
            logger.error("editJob failed: \(error.localizedDescription)")
        }
    }
}


// MARK: - Func

extension RecommendViewModel {
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
