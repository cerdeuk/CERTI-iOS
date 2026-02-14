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
    let addCommentUseCase: AddCommentUseCase
    let deleteCommentUseCase: DeleteCommentUseCase
    let likeCommentUseCase: LikeCommentUseCase
    let reportCommentUseCase: ReportCommentUseCase
    
    init(
        fetchCertificationDetailUseCase: FetchCertificationDetailUseCase,
        addPreCertificationUseCase: AddPreCertificationUseCase,
        addAcquisitionUseCase: AddAcquisitionUseCase,
        fetchCommentUseCase: FetchCommentUseCase,
        addCommentUseCase: AddCommentUseCase,
        deleteCommentUseCase: DeleteCommentUseCase,
        likeCommentUseCase: LikeCommentUseCase,
        reportCommentUseCase: ReportCommentUseCase
    ) {
        self.fetchCertificationDetailUseCase = fetchCertificationDetailUseCase
        self.addPreCertificationUseCase = addPreCertificationUseCase
        self.addAcquisitionUseCase = addAcquisitionUseCase
        self.fetchCommentUseCase = fetchCommentUseCase
        self.addCommentUseCase = addCommentUseCase
        self.deleteCommentUseCase = deleteCommentUseCase
        self.likeCommentUseCase = likeCommentUseCase
        self.reportCommentUseCase = reportCommentUseCase
    }
    
    @MainActor
    func makeCertificateDetailViewModel() -> CertificateDetailViewModel {
        CertificateDetailViewModel(
            fetchCertificationDetailUseCase: fetchCertificationDetailUseCase,
            addPreCertificationUseCase: addPreCertificationUseCase,
            addAcquisitionUseCase: addAcquisitionUseCase,
            fetchCommentUseCase: fetchCommentUseCase,
            addCommentUseCase: addCommentUseCase,
            deleteCommentUseCase: deleteCommentUseCase,
            likeCommentUseCase: likeCommentUseCase,
            reportCommentUseCase: reportCommentUseCase
        )
    }
}
