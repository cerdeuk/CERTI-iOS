//
//  ActivityAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

enum ActivityAPI {
    case fetchActivityList
}

extension ActivityAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchActivityList:
            return "activity"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchActivityList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchActivityList:
            return .requestPlain
        }
    }
    
    
}
