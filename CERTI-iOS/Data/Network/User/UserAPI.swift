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
}

extension UserAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getUserInfo:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getUserInfo:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserInfo:
            return .requestPlain
        }
    }
    
    
}
