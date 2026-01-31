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
    case addComment(request: CommentRequestDTO)
    case deleteComment(commentId: Int)
    case likeComment(commentId: Int)
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
        case .addComment:
            return "comments"
        case .deleteComment(let commentId):
            return "comments/\(commentId)"
        case .likeComment(let commentId):
            return "comments/\(commentId)/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getComment:
            return .get
        case .addComment:
            return .post
        case .deleteComment:
            return .delete
        case .likeComment:
            return .post
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
        case .addComment(let request):
            return .requestJSONEncodable(request)
        case .deleteComment:
            return .requestPlain
        case .likeComment:
            return .requestPlain
        }
    }
}
