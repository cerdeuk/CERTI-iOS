//
//  CertificationAPI.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

enum  CertificationAPI {
    case fetchCategoryList(isFavorite: Bool, jobs: String)
    case switchFavorite(certificationId: Int)
}

extension CertificationAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .fetchCategoryList:
            return "certification"
        case .switchFavorite(certificationId: let certificationId):
            return "certification/\(certificationId)/favorite"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCategoryList:
            return .get
        case .switchFavorite:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCategoryList(let isFavorite, let jobs):
            return .requestParameters(parameters: ["isFavorite":isFavorite, "jobs":jobs], encoding: URLEncoding.queryString)
        case .switchFavorite:
            return .requestPlain
        }
    }
}
