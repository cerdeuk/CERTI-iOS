//
//  UserAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

enum UserAPI {
    case getUserInfo
    case checkNickname(nickname: String)
}

extension UserAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getUserInfo:
            return .accessTokenHeader
        case .checkNickname(nickname: let nickname):
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getUserInfo:
            return "user"
        case .checkNickname:
            return "user/validation"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo:
            return .get
        case .checkNickname:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserInfo:
            return .requestPlain
        case .checkNickname(nickname: let nickname):
            return .requestParameters(
                parameters: ["keyword": nickname],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    
}
