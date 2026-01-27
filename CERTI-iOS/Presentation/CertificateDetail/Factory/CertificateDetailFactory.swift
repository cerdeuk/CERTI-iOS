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
    let fetchCommentUseCase: FetchCommentUseCase
    
    init(
        fetchCertificationDetailUseCase: FetchCertificationDetailUseCase,
        addPreCertificationUseCase: AddPreCertificationUseCase,
        addAcquisitionUseCase: AddAcquisitionUseCase,
        fetchCommentUseCase: FetchCommentUseCase
    ) {
        self.fetchCertificationDetailUseCase = fetchCertificationDetailUseCase
        self.addPreCertificationUseCase = addPreCertificationUseCase
        self.addAcquisitionUseCase = addAcquisitionUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
    }
    
    @MainActor
    func makeCertificateDetailViewModel() -> CertificateDetailViewModel {
        CertificateDetailViewModel(
            fetchCertificationDetailUseCase: fetchCertificationDetailUseCase,
            addPreCertificationUseCase: addPreCertificationUseCase,
            addAcquisitionUseCase: addAcquisitionUseCase,
            fetchCommentUseCase: fetchCommentUseCase
        )
    }
}
