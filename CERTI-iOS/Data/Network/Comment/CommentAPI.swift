//
//  CommentAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

import Moya

enum CommentAPI {
    case getComment(certificationId: Int, page: Int, size: Int, sort: String)
}

extension CommentAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getComment:
            return "comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getComment:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getComment(let certificationId, let page, let size, let sort):
            return .requestParameters(parameters: [
                "certificationId": certificationId,
                "page": page,
                "size": size,
                "sort": sort
            ], encoding: URLEncoding.queryString)
        }
    }
}
