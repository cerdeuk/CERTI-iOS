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
    case deletePreCertification(id: Int)
}

extension HomeAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getPreCertification:
            return .accessTokenHeader
        case .deletePreCertification:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getPreCertification:
            return "home/pre-certification"
        case .deletePreCertification(let id):
            return "home/pre-certification/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPreCertification:
            return .get
        case .deletePreCertification:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPreCertification:
            return .requestPlain
        case .deletePreCertification:
            return .requestPlain
        }
    }
    
}
