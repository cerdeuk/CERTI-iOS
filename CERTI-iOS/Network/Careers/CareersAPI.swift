//
//  CareersAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

import Moya

enum CareersAPI {
    case fetchCareersList
}

extension CareersAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchCareersList:
            return "careers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCareersList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCareersList:
            return .requestPlain
        }
    }
    
    
}
