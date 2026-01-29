//
//  CertificateViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import Foundation
import os

enum CertificateViewRoute {
    case navigateToSearch
    case navigateToCertificateDetail
    case navigateTotrackList  // 계열별 자격증
    case navigateTojobList    // 직무별 자격증
    
    case certificateViewRoutePop
}

@MainActor
final class CertificateViewModel: ObservableObject {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "CertificateViewModel")

    @Published var certificateViewRoute: CertificateViewRoute?
    
//    @Published var licenseCards: [CertificateListTileModel] = []
    @Published var recommendCertificates: [RecommendCeritificateTileModel] = []
    @Published var trackRankCertificates: [RankCeritificateTileModel] = []
    @Published var jobRankCertificates: [RankCeritificateTileModel] = []
    @Published var licenseCards: [CertificateListTileModel] = CertificateListTileModel.dummyData
    @Published var searchLicenseCards: [CertificateListTileModel] = []
    @Published var inputText: String = ""
    @Published var searchResult: SearchResultType? = nil
    @Published var selectedCertificateId: Int = 0
    
    var trimmedInput: String {
        inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - Usecases
    
    private let fetchRecommendUseCase: FetchRecommendUseCase
    private let getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase
    private let getJobRankCertificationUsecase: GetJobRankCertificationUsecase
    
    
    
    // MARK: - init
    
    init(
        fetchRecommendUseCase: FetchRecommendUseCase,
        getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase,
        getJobRankCertificationUsecase: GetJobRankCertificationUsecase,
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
        self.getTrackRankCertificationUsecase = getTrackRankCertificationUsecase
        self.getJobRankCertificationUsecase = getJobRankCertificationUsecase
    }
    
}


// MARK: - Network Func

extension CertificateViewModel {
    func fetchRecommend() async {
        let result = await fetchRecommendUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchRecommend success")
            let recommendations: [RecommendCeritificateTileModel] = response.certifications.prefix(3).map {
                RecommendCeritificateTileModel(
                    id: $0.certificationId,
                    title: $0.certificationName,
                    score: $0.recommendScore!,
                    description: $0.description!,
                    tags: $0.tags
                )
            }
            self.recommendCertificates = recommendations
        case .failure(let error):
            logger.error("❌ fetchRecommend failed: \(error.localizedDescription)")
        }
    }
    
    func fetchTrackRank() async {
        let result = await getTrackRankCertificationUsecase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchTrackRank success")
            let trackRank: [RankCeritificateTileModel] = response.map {
                RankCeritificateTileModel(
                    id: $0.certificationID,
                    rank: $0.rank,
                    title: $0.certificationName,
                    type: $0.certificationType
                )
            }
            self.trackRankCertificates = trackRank
            
        case .failure(let error):
            logger.error("❌ fetchTrackRank failed: \(error.localizedDescription)")
        }
    }
    
    func fetchJobRank() async {
        let result = await getJobRankCertificationUsecase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchJobRank success")
            let jobRank: [RankCeritificateTileModel] = response.map {
                RankCeritificateTileModel(
                    id: $0.certificationID,
                    rank: $0.rank,
                    title: $0.certificationName,
                    type: $0.certificationType
                )
            }
            self.jobRankCertificates = jobRank
            
        case .failure(let error):
            logger.error("❌ fetchJobRank failed: \(error.localizedDescription)")
        }
    }
}


// MARK: - Navigation Func

extension CertificateViewModel {
    
    func navigateToSearch() {
        certificateViewRoute = .navigateToSearch
    }
    
    func navigateToCertificateDetail() {
        certificateViewRoute = .navigateToCertificateDetail
    }
    
    func navigateTotrackList() {
        certificateViewRoute = .navigateTotrackList
    }
    
    func navigateTojobList() {
        certificateViewRoute = .navigateTojobList
    }
    
    func certificateViewRoutePop() {
        certificateViewRoute = .certificateViewRoutePop
    }
}
