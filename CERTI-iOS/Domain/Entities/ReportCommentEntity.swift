//
//  ReportCommentEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

struct ReportCommentEntity {
    let content: String?
    let shouldBlockUser: Bool
}

// MARK: - Func

extension ReportCommentEntity {
    func toReportCommentRequestDTO() -> ReportCommentRequestDTO {
        return ReportCommentRequestDTO(content: content, shouldBlockUser: shouldBlockUser)
    }
}
