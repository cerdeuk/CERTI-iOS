//
//  ReportAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/11/26.
//

import Foundation

import Moya

enum ReportAPI {
    case reportComment(commentId: Int, request: ReportCommentRequestDTO)
}

extension ReportAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .reportComment(let commentId, _):
            return "report/comment/\(commentId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reportComment:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .reportComment(_, let request):
            return .requestJSONEncodable(request)
        }
    }
}
