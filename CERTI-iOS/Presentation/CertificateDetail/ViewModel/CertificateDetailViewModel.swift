//
//  CertificateDetailViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import SwiftUI

import os

@MainActor
final class CertificateDetailViewModel: ObservableObject {
    @Published var certificateDetailModel = CertificateDetailModel(
        certificationId: 0,
        certificationName: "",
        tags: [],
        averagePeriod: "",
        charge: "0",
        agencyName: "",
        testType: "",
        description: "",
        testDateInformation: "",
        applicationMethod: "",
        applicationUrl: "www.google.com",
        expirationPeriod: ""
    )
    @Published var showSuccessToBeAcquired: Bool = false
    @Published var showFailAcquired: Bool = false
    @Published var showFailToBeAcquired: Bool = false
    @Published var showCompleteModal = false
    @Published var CertificationPlanDate: Date? = nil
    @Published var CertificationPlanPlaceProvince: String? = nil
    @Published var CertificationPlanPlaceCity: String? = nil
    @Published var isAM = true
    @Published var hour = 1
    @Published var minute = 0
    @Published var isSelectedPopularity = false
    @Published var commentCount = 0
    @Published var paginationComments: [PaginationCommentModel] = []
    @Published var comments = Comment(
        commentId: 0,
        userId: 0,
        nickName: nil,
        content: "",
        userMajor: "",
        userJob: "",
        state: "",
        likeCount: 0,
        createdTime: "",
        lastModifiedTime: "",
        isLike: false
    )
    @Published var isLoadingComments: Bool = false
    @Published var isLastPage: Bool = false
    @Published var commentIndex = 1
    @Published var commentText = ""
    
    private var dummyPages: [PaginationCommentModel] = PaginationCommentModel.dummy()
    var currentPageIndex: Int = 0
    
    var commentList: [Comment] {
        paginationComments.flatMap { $0.content }
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "CertificationDetail")
    
    private let fetchCertificationDetailUseCase: FetchCertificationDetailUseCase
    private let addPreCertificationUseCase: AddPreCertificationUseCase
    private let addAcquisitionUseCase: AddAcquisitionUseCase
    private let fetchCommentUseCase: FetchCommentUseCase
    
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
}


// MARK: - Network

extension CertificateDetailViewModel {
    func fetchCertificateDetail(certificationId: Int) async {
        let result = await fetchCertificationDetailUseCase.execute(id: certificationId)
        
        switch result {
        case .success(let response):
            self.certificateDetailModel = response.toCertificationDetailModel()
            logger.debug("✅ CertificationDetail success: \(String(describing: self.certificateDetailModel))")
            
        case .failure(let error):
            logger.error("CertificationDetail failed: \(error.localizedDescription)")
        }
    }
    
    func appendPreCertification(certificationId: Int) async {
        let result = await addPreCertificationUseCase.execute(certificationId: certificationId)
        
        switch result {
        case .success(let status):
            switch status {
            case .success: showSuccessToBeAcquired = true
            case .conflictError: showFailAcquired = true
            case .duplicationError: showFailToBeAcquired = true
            }
            logger.debug("✅ appendPreCertification success")
            
        case .failure(let error):
            logger.error("appendPreCertification failed: \(error.localizedDescription)")
        }
    }
    
    func appendAcquisition(certificationId: Int) async {
        let result = await addAcquisitionUseCase.execute(certificationId: certificationId)
        
        switch result {
        case .success(let response):
            if response {
                showCompleteModal = true
            } else {
                showFailAcquired = true
            }
            logger.debug("✅ appendAcquisition success")
            
        case .failure(let error):
            logger.error("appendAcquisition failed: \(error.localizedDescription)")
        }
    }
        
    // UI 확인용 더미
    func loadNextComments() async {
        guard !isLoadingComments && !isLastPage else { return }
        guard currentPageIndex < dummyPages.count else {
            isLastPage = true
            return
        }
        
        isLoadingComments = true
        
        try? await Task.sleep(nanoseconds: 600_000_000)
        
        let nextPage = dummyPages[currentPageIndex]
        paginationComments.append(nextPage)
        currentPageIndex += 1
        
        commentCount = paginationComments
            .flatMap { $0.content }
            .count
        
        isLastPage = nextPage.isLast
        isLoadingComments = false
    }
}

// MARK: - Func

extension CertificateDetailViewModel {
    func resetPlanModalInput() {
        CertificationPlanDate = nil
        CertificationPlanPlaceProvince = nil
        CertificationPlanPlaceCity = nil
        
        isAM = true
        hour = 1
        minute = 0
    }
    
    func countAppearComment() {
        commentIndex += 1
    }
}
