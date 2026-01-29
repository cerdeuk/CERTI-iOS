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
    
    
    @MainActor
    func makeCertificateViewModel() -> CertificateViewModel {
        CertificateViewModel(
            fetchRecommendUseCase: fetchRecommendUseCase,
            getTrackRankCertificationUsecase: getTrackRankCertificationUsecase,
            getJobRankCertificationUsecase: getJobRankCertificationUsecase
        )
    }
}

