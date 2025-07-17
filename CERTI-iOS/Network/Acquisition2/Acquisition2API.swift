//
//  Acquisition2API.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

import Moya

enum Acquisition2API {
    case addAcquisition(certificationId: Int)
}

extension Acquisition2API: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .addAcquisition(let certificationId):
            return "acquisition/\(certificationId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addAcquisition:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addAcquisition:
            return .requestPlain
        }
    }
}
