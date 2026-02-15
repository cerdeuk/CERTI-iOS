//
//  ReportCommentUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

protocol ReportCommentUseCase {
    func execute(commentId: Int, request: ReportCommentEntity) async -> Result<Void, NetworkError>
}

final class DefaultReportCommentUseCase: ReportCommentUseCase {
    private let repository: ReportRepository
    
    init(repository: ReportRepository) {
        self.repository = repository
    }

    func execute(commentId: Int, request: ReportCommentEntity) async -> Result<Void, NetworkError> {
        return await repository.reportComment(commentId: commentId, request: request)
    }
}
