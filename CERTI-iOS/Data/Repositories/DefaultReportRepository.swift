//
//  DefaultReportRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

import Moya

final class DefaultReportRepository: ReportRepository {
    private let service: ReportServiceProtocol
    
    public init(service: ReportServiceProtocol) {
        self.service = service
    }
    
    func reportComment(commentId: Int, request: ReportCommentEntity) async -> Result<Void, NetworkError> {
        let requestDTO = request.toReportCommentRequestDTO()
        return await service.reportComment(commentId: commentId, request: requestDTO)
    }
}
