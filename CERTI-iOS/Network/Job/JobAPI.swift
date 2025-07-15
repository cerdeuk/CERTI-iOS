//
//  JobAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import Foundation

import Moya

enum JobAPI {
    case fetchJob
}

extension JobAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchJob:
            return "user/job"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchJob:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchJob:
            return .requestPlain
        }
    }
}

