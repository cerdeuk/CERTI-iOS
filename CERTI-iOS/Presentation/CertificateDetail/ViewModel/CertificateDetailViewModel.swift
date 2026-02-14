//
//  CertificateDetailViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import SwiftUI

import os

enum CertificationState: String {
    case anticipated = "ANTICIPATED"
    case acquisition = "ACQUISITION"
    case normal = "NORMAL"
}

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
        expirationPeriod: "",
        certState: ""
    )
    @Published var showSuccessToBeAcquired: Bool = false
    @Published var showFailAcquired: Bool = false
    @Published var showFailToBeAcquired: Bool = false
    @Published var showCompleteModal = false
    @Published var showDeleteCommentAlert: Bool = false
    @Published var stateCommentReportModal: Bool = false
    @Published var deleteCommentId: Int? = nil
    @Published var reportCommentId: Int = 0
    @Published var CertificationPlanDate: Date? = nil
    @Published var CertificationPlanPlaceProvince: String? = nil
    @Published var CertificationPlanPlaceCity: String? = nil
    @Published var isAM = true
    @Published var hour = 1
    @Published var minute = 0
    @Published var isSelectedPopularity = true
    @Published var commentCount = 0
    @Published var paginationComments: [PaginationCommentModel] = []
    @Published var comments: [Comment] = []
    @Published var isLoadingComment = false
    @Published var isLastPage = false
    @Published var commentIndex = 1
    @Published var commentText = ""
    @Published var addPreCertificationModel = PreCertificationModel(
        certificationId: 0, city: nil, state: nil, testDate: nil
    )
    @Published var reportContent: String = ""
    @Published var shouldBlockUser: Bool = false
    
    private var currentPage: Int = 0
    private let pageSize: Int = 10
    let placeMenuOptions = Region.allCases.map(\.rawValue)
    
    var placeMenuOptions2: [String] {
        guard
            let city = addPreCertificationModel.city,
            let region = Region(rawValue: city)
        else { return [] }
        return region.districts
    }
    var currentUserId: Int = AuthManager.shared.userID
    var currentPageIndex: Int = 0
    var commentList: [Comment] {
        paginationComments.flatMap { $0.content }
    }
    var certificationState: CertificationState? {
        CertificationState(rawValue: certificateDetailModel.certState)
    }
    var isCommentWritable: Bool {
        guard let state = certificationState else { return false }
        return state == .anticipated || state == .acquisition
    }
    var reportContentCountWithoutWhitespace: Int {
        reportContent.filter { !$0.isWhitespace && !$0.isNewline }.count
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "CertificationDetail")
    
    private let fetchCertificationDetailUseCase: FetchCertificationDetailUseCase
    private let addPreCertificationUseCase: AddPreCertificationUseCase
    private let addAcquisitionUseCase: AddAcquisitionUseCase
    private let fetchCommentUseCase: FetchCommentUseCase
    private let addCommentUseCase: AddCommentUseCase
    private let deleteCommentUseCase: DeleteCommentUseCase
    private let likeCommentUseCase: LikeCommentUseCase
    private let reportCommentUseCase: ReportCommentUseCase
    
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
    
    func appendPreCertification(request: PreCertificationModel) async {
        let result = await addPreCertificationUseCase.execute(request: request.toPreCertificationEntity())
        
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
        let entity = AddAcquisitionEntity(certificationId: certificationId)
        let result = await addAcquisitionUseCase.execute(request: entity)
        
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
    
    func fetchComment(certificationId: Int) async {
        guard !isLoadingComment, !isLastPage else { return }

        isLoadingComment = true

        let result = await fetchCommentUseCase.execute(
            certificationId: certificationId,
            page: currentPage,
            size: pageSize,
            sort: isSelectedPopularity ? "likeCount,desc" : ""
        )

        switch result {
        case .success(let response):
            let pageModel = response.toPaginationCommentModel()

            comments.append(contentsOf: pageModel.content)

            commentCount = pageModel.totalElements
            isLastPage = pageModel.isLast

            currentPage += 1

        case .failure(let error):
            logger.error("❌ 댓글 조회 실패: \(error.localizedDescription)")
        }

        isLoadingComment = false
    }

    func addComment(content: String, certificationId: Int) async {
        let entity = AddCommentEntity(content: content, certificationId: certificationId)
        let result = await addCommentUseCase.execute(request: entity)

        switch result {
        case .success:
            commentText = ""

            currentPage = 0
            isLastPage = false
            comments.removeAll()

            await fetchComment(certificationId: certificationId)

        case .failure(let error):
            logger.error("❌ 댓글 등록 실패: \(error.localizedDescription)")
        }
    }
    
    func toggleLike(commentId: Int) async {
        let result = await likeCommentUseCase.execute(commentId: commentId)

        switch result {
        case .success:
            if let index = comments.firstIndex(where: { $0.commentId == commentId }) {
                comments[index].isLike.toggle()
                comments[index].likeCount += comments[index].isLike ? 1 : -1
            }

        case .failure(let error):
            print("❌ 댓글 좋아요 실패:", error)
        }
    }
    
    func deleteComment(commentId: Int) async {
        let result = await deleteCommentUseCase.execute(commentId: commentId)

        switch result {
        case .success:
            comments.removeAll { $0.commentId == commentId }

        case .failure(let error):
            print("❌ 댓글 삭제 실패:", error)
        }
    }
    
    func reportComment(commentId:Int, content: String?, shouldBlockUser: Bool) async {
        let entity = ReportCommentEntity(content: content, shouldBlockUser: shouldBlockUser)
        let result = await reportCommentUseCase.execute(commentId: commentId, request: entity)

        switch result {
        case .success:
            logger.debug("✅ 댓글 신고 성공")

        case .failure(let error):
            logger.error("❌ 댓글 신고 실패: \(error.localizedDescription)")
        }
    }
    
    func refreshComments(certificationId: Int) async {
        currentPage = 0
        isLastPage = false
        isLoadingComment = false
        comments.removeAll()

        await fetchComment(certificationId: certificationId)
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
    
    func makePlannedDateTimeString() -> String? {
            guard let date = CertificationPlanDate else {
                return nil
            }

            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "ko_KR")

            var components = calendar.dateComponents([.year, .month, .day], from: date)

            let convertedHour: Int
            if isAM {
                convertedHour = hour == 12 ? 0 : hour
            } else {
                convertedHour = hour == 12 ? 12 : hour + 12
            }

            components.hour = convertedHour
            components.minute = minute
            components.second = 0

            guard let finalDate = calendar.date(from: components) else {
                return nil
            }

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

            return formatter.string(from: finalDate)
        }
    
    func clearPreCertificationModel() {
        addPreCertificationModel = PreCertificationModel(certificationId: 0, city: nil, state: nil, testDate: nil)
    }
    
    func resetComments() {
        comments.removeAll()
        currentPage = 0
        isLastPage = false
        isLoadingComment = false
    }
    
    func showDeleteCommentModal(commentId: Int) {
        deleteCommentId = commentId
        showDeleteCommentAlert = true
    }

    func dismissDeleteCommentModal() {
        deleteCommentId = nil
        showDeleteCommentAlert = false
    }
    
    func showCommentReportModal(commentId: Int) {
        reportCommentId = commentId
        stateCommentReportModal = true
    }

    func dismissCommentReportModal() {
        reportCommentId = 0
        stateCommentReportModal = false
        reportContent = ""
        shouldBlockUser = false
    }
    
    func updateReportContent(_ text: String) {
        var result = ""
        var nonSpaceCount = 0
        
        for char in text {
            if !char.isWhitespace && !char.isNewline {
                nonSpaceCount += 1
            }
            
            if nonSpaceCount > 100 { break }
            
            result.append(char)
        }
        
        reportContent = result
    }
}
