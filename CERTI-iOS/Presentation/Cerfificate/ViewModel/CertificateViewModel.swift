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
    @Published var selectedLicenseId: Int = 0
    @Published var username = AuthManager.shared.nickname

    // 랭킹관련
    @Published var recommendCertificates: [RecommendCeritificateTileModel] = []
    @Published var trackRankCertificates: [RankCeritificateTileModel] = []
    @Published var jobRankCertificates: [RankCeritificateTileModel] = []

    // 검색관련
    @Published var searchLicenseCards: [CertificateListTileModel] = []
    @Published var inputText: String = ""
    @Published var searchResult: SearchResultType? = nil
    @Published var selectedCertificateId: Int = 0
    
    // 직무별, 계열별 관련
    @Published var licenseCards: [CertificateListTileModel] = []
    @Published var selectedJob: JobCategory = .business
    @Published var selectedTrack: TrackList = .management
    
    var trimmedInput: String {
        inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - Usecases
    
    private let fetchRecommendUseCase: FetchRecommendUseCase
    private let getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase
    private let getJobRankCertificationUsecase: GetJobRankCertificationUsecase
    private let getJobCertificationListUsecase: GetJobCertificationListUsecase
    private let getTrackCertificationListUsecase: GetTrackCertificationListUsecase
    private let fetchJobUseCase: FetchJobUseCase
    private let fetchTrackUsecase: FetchTrackUsecase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let searchCertificationUseCase: SearchCertificationUseCase

    
    // MARK: - init
    
    init(
        fetchRecommendUseCase: FetchRecommendUseCase,
        getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase,
        getJobRankCertificationUsecase: GetJobRankCertificationUsecase,
        getJobCertificationListUsecase: GetJobCertificationListUsecase,
        getTrackCertificationListUsecase: GetTrackCertificationListUsecase,
        fetchJobUseCase: FetchJobUseCase,
        fetchTrackUsecase: FetchTrackUsecase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        searchCertificationUseCase: SearchCertificationUseCase,
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
        self.getTrackRankCertificationUsecase = getTrackRankCertificationUsecase
        self.getJobRankCertificationUsecase = getJobRankCertificationUsecase
        self.getJobCertificationListUsecase = getJobCertificationListUsecase
        self.getTrackCertificationListUsecase = getTrackCertificationListUsecase
        self.fetchJobUseCase = fetchJobUseCase
        self.fetchTrackUsecase = fetchTrackUsecase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.searchCertificationUseCase = searchCertificationUseCase
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
    
    func fetchJob() async {
        let fetchJobList = await fetchJobUseCase.execute()
        
        switch fetchJobList {
        case .success(let response):
            guard let data = response.jobs.first else { return }
            self.selectedJob = JobCategory(rawValue: data)!
        case .failure(let error):
            logger.error("❌ fetchJobList failed: \(error.localizedDescription)")
        }
    }
    
    func fetchJobList() async {
        let result = await getJobCertificationListUsecase.execute(job: selectedJob.description)
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchJobList success")
            let jobList: [CertificateListTileModel] = response.certificationSimpleList.map {
                CertificateListTileModel(
                    id: $0.certificationID,
                    title: $0.certificationName,
                    type: $0.certificationType,
                    description: $0.description,
                    tags: $0.tags,
                    testType: $0.testType,
                    isFavorite: $0.isFavorite
                )
            }
            self.licenseCards.removeAll()
            self.licenseCards = jobList
            
        case .failure(let error):
            logger.error("❌ fetchJobList failed: \(error.localizedDescription)")
        }
    }
    
    func fetchTrack() async {
        let track = await fetchTrackUsecase.execute()
        
        switch track {
        case .success(let response):
            logger.debug("✅ fetchJobList success")
            self.selectedTrack = TrackList(rawValue: response)!
        case .failure(let error):
            logger.error("❌ fetchTrack failed: \(error.localizedDescription)")
        }
    }
    
    func fetchTrackList() async {
        let result = await getTrackCertificationListUsecase.execute(track: selectedTrack.description)
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchTrackList success")
            let trackList: [CertificateListTileModel] = response.certificationSimpleList.map {
                CertificateListTileModel(
                    id: $0.certificationID,
                    title: $0.certificationName,
                    type: $0.certificationType,
                    description: $0.description,
                    tags: $0.tags,
                    testType: $0.testType,
                    isFavorite: $0.isFavorite
                )
            }
            self.licenseCards.removeAll()
            self.licenseCards = trackList
            
        case .failure(let error):
            logger.error("❌ fetchTrackList failed: \(error.localizedDescription)")
        }
    }
    
    func toggleFavorite(id: Int) async {
        let result = await switchFavoriteUseCase.execute(id: id)
        
        switch result {
        case .success:
            logger.debug("✅ toggleFavorite success")
            if let index = licenseCards.firstIndex(where: { $0.id == id }) {
                licenseCards[index].isFavorite.toggle()
            }
        case .failure(let error):
            logger.error("❌ toggleFavorite failed: \(error.localizedDescription)")
        }
    }
    
    func searchCertifiedList(keyword: String) async {
            let result = await searchCertificationUseCase.execute(keyword: keyword)
            
            switch result {
            case .success(let response):
                self.searchLicenseCards.removeAll()
                
                let list: [CertificateListTileModel] = response.certifications.map {
                    CertificateListTileModel(
                        id: $0.certificationId,
                        title: $0.certificationName,
                        type: $0.certificationType,
                        description: $0.description ?? "",
                        tags: $0.tags,
                        testType: $0.testType,
                        isFavorite: $0.isFavorite
                    )
                }
                
                self.searchLicenseCards = list
                logger.debug("✅ searchCertifiedList success: \(response.toLicenseCardModelList())")
                
            case .failure(let error):
                logger.error("searchCertifiedList failed: \(error.localizedDescription)")
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
