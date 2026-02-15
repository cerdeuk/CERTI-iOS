//
//  ReportRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

import Moya

protocol ReportRepository {
    func reportComment(commentId: Int, request: ReportCommentEntity) async -> Result<Void, NetworkError>
}
