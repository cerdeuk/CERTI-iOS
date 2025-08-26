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
    let addPreCertificationUseCase: AddPreCertificationUseCase
    let addAcquisitionUseCase: AddAcquisitionUseCase
    
    init(
        fetchCertificationDetailUseCase: FetchCertificationDetailUseCase,
        addPreCertificationUseCase: AddPreCertificationUseCase,
        addAcquisitionUseCase: AddAcquisitionUseCase
    ) {
        self.fetchCertificationDetailUseCase = fetchCertificationDetailUseCase
        self.addPreCertificationUseCase = addPreCertificationUseCase
        self.addAcquisitionUseCase = addAcquisitionUseCase
    }
    
    @MainActor
    func makeCertificateDetailViewModel() -> CertificateDetailViewModel {
        CertificateDetailViewModel(
            fetchCertificationDetailUseCase: fetchCertificationDetailUseCase,
            addPreCertificationUseCase: addPreCertificationUseCase,
            addAcquisitionUseCase: addAcquisitionUseCase
        )
    }
}
