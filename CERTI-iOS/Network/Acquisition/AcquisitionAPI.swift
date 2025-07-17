//
//  AcquisitionAPI.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

import Moya

enum AcquisitionAPI {
    case fetchAcquisitionList
}

extension AcquisitionAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchAcquisitionList:
            return "acquisition"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAcquisitionList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAcquisitionList:
            return .requestPlain
        }
    }
    
    
}
