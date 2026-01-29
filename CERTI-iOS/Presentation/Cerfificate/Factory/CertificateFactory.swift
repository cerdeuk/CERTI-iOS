//
//  CertificateFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

protocol CertificateFactory {
    @MainActor func makeCertificateViewModel() -> CertificateViewModel
}

final class DefaultCertificateFactory: CertificateFactory {
    
    // MARK: - Usecases

    private let fetchRecommendUseCase: FetchRecommendUseCase
    private let getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase
    private let getJobRankCertificationUsecase: GetJobRankCertificationUsecase
    private let getJobCertificationListUsecase: GetJobCertificationListUsecase
    private let getTrackCertificationListUsecase: GetTrackCertificationListUsecase
    private let fetchJobUseCase: FetchJobUseCase
    private let fetchTrackUsecase: FetchTrackUsecase
    
    
    // MARK: - init

    init(
        fetchRecommendUseCase: FetchRecommendUseCase,
        getTrackRankCertificationUsecase: GetTrackRankCertificationUsecase,
        getJobRankCertificationUsecase: GetJobRankCertificationUsecase,
        getJobCertificationListUsecase: GetJobCertificationListUsecase,
        getTrackCertificationListUsecase: GetTrackCertificationListUsecase,
        fetchJobUseCase: FetchJobUseCase,
        fetchTrackUsecase: FetchTrackUsecase,
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
        self.getTrackRankCertificationUsecase = getTrackRankCertificationUsecase
        self.getJobRankCertificationUsecase = getJobRankCertificationUsecase
        self.getJobCertificationListUsecase = getJobCertificationListUsecase
        self.getTrackCertificationListUsecase = getTrackCertificationListUsecase
        self.fetchJobUseCase = fetchJobUseCase
        self.fetchTrackUsecase = fetchTrackUsecase
    }
    
    
    @MainActor
    func makeCertificateViewModel() -> CertificateViewModel {
        CertificateViewModel(
            fetchRecommendUseCase: fetchRecommendUseCase,
            getTrackRankCertificationUsecase: getTrackRankCertificationUsecase,
            getJobRankCertificationUsecase: getJobRankCertificationUsecase,
            getJobCertificationListUsecase: getJobCertificationListUsecase,
            getTrackCertificationListUsecase: getTrackCertificationListUsecase,
            fetchJobUseCase: fetchJobUseCase,
            fetchTrackUsecase: fetchTrackUsecase
        )
    }
}

