//
//  CertificationAPI.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

enum  CertificationAPI {
    case viewCategoryList(isFavorite: Bool, jobs: String)
    
    case toggleFavorite(certificationId: Int)
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
        case .viewCategoryList:
            return "certification"
            
        case .toggleFavorite(certificationId: let certificationId):
            return "certification/\(certificationId)/favorite"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .viewCategoryList:
            return .get
            
        case .toggleFavorite:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .viewCategoryList(let isFavorite, let jobs):
            return .requestParameters(parameters: ["isFavorite":isFavorite, "jobs":jobs], encoding: URLEncoding.queryString)
            
        case .toggleFavorite:
            return .requestPlain
        }
    }
}
