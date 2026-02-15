//
//  ReportService.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

import Moya

protocol ReportServiceProtocol {
    func reportComment(commentId: Int, request: ReportCommentRequestDTO) async -> Result<Void, NetworkError>
}

final class ReportService: BaseService, ReportServiceProtocol {
    private let provider = MoyaProvider<ReportAPI>.init(plugins: [MoyaPlugin()])
    
    func reportComment(commentId: Int, request: ReportCommentRequestDTO) async -> Result<Void, NetworkError> {
        return await requestVoid(provider, .reportComment(commentId: commentId, request: request))
    }
}
