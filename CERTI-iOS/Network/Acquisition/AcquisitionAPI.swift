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
    case addAcquisition(certificationId: Int)
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
        case .addAcquisition(let certificationId):
            return "acquisition/\(certificationId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAcquisitionList:
            return .get
        case .addAcquisition:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAcquisitionList:
            return .requestPlain
        case .addAcquisition:
            return .requestPlain
        }
    }
    
    
}
