//
//  CertificationAPI.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

import Moya

enum CertificationAPI {
    case fetchCategoryList(isFavorite: Bool, jobs: String)
    case switchFavorite(certificationId: Int)
    case searchCertification(keyword: String)
    case fetchCertificationDetail(certificationId: Int)
    case getRecommendCertification
    case getTrackRankCertification
    case getJobRankCertification
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
        case .searchCertification:
            return "certification/search"
        case .fetchCertificationDetail(certificationId: let certificationId):
            return "certification/\(certificationId)"
        case .getRecommendCertification:
            return "certification/recommend"
        case .getTrackRankCertification:
            return "certification/track"
        case .getJobRankCertification:
            return "certification/job"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCategoryList:
            return .get
        case .switchFavorite:
            return .post
        case .searchCertification:
            return .get
        case .fetchCertificationDetail:
            return .get
        case .getRecommendCertification:
            return .get
        case .getTrackRankCertification:
            return .get
        case .getJobRankCertification:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCategoryList(let isFavorite, let jobs):
            return .requestParameters(parameters: ["isFavorite":isFavorite, "jobs":jobs], encoding: URLEncoding.queryString)
        case .switchFavorite:
            return .requestPlain
        case .searchCertification(let keyword):
            return .requestParameters(parameters: ["keyword":keyword], encoding: URLEncoding.queryString)
        case .fetchCertificationDetail:
            return .requestPlain
        case .getRecommendCertification:
            return .requestPlain
        case .getTrackRankCertification:
            return .requestPlain
        case .getJobRankCertification:
            return .requestPlain
        }
    }
}
