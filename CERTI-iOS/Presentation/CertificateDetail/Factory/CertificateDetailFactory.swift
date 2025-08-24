//
//  CertificateDetailFactory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import SwiftUI

protocol CertificateDetailFactory {
    @MainActor func makeCertificateDetailViewModel() -> CertificateDetailViewModel
}

final class DefaultCertificationDetailFactory: CertificateDetailFactory {
    let fetchCertificationDetailUseCase: FetchCertificationDetailUseCase
    
    init(
        fetchCertificationDetailUseCase: FetchCertificationDetailUseCase
    ) {
        self.fetchCertificationDetailUseCase = fetchCertificationDetailUseCase
    }
    
    @MainActor
    func makeCertificateDetailViewModel() -> CertificateDetailViewModel {
        CertificateDetailViewModel(
            fetchCertificationDetailUseCase: fetchCertificationDetailUseCase
        )
    }
}
