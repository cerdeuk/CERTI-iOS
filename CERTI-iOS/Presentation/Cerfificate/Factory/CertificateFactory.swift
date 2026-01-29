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
    
    
    // MARK: - init

    init(
        fetchRecommendUseCase: FetchRecommendUseCase
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
    }
    
    @MainActor
    func makeCertificateViewModel() -> CertificateViewModel {
        CertificateViewModel(
            fetchRecommendUseCase: fetchRecommendUseCase
        )
    }
}

