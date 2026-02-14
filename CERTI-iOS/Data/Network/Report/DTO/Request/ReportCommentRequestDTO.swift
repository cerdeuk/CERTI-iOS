//
//  ReportCommentRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

struct ReportCommentRequestDTO: Encodable {
    let content: String?
    let shouldBlockUser: Bool
}
