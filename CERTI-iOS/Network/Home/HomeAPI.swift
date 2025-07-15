//
//  HomeAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

import Moya

enum HomeAPI {
    case getPreCertification
}

extension HomeAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getPreCertification:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getPreCertification:
            return "home/pre-certification"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPreCertification:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPreCertification:
            return .requestPlain
        }
    }
    
}
