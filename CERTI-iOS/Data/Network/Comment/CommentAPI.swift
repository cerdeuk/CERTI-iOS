//
//  CommentAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

import Moya

enum CommentAPI {
    case getComment
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
        case .getComment:
            return .requestPlain
        }
    }
}
