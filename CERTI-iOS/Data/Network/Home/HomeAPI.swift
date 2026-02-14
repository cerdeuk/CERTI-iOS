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
    case getFavoriteCertification
    case getMonthlyPreCertification(year: Int, month: Int)
    case getDailyPreCertification(date: String)
    case addPreCertification(request: AddPreCertificationRequestDTO)
    case editPreCertification(request: EditPreCertificationRequestDTO, id: Int)
}

extension HomeAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getPreCertification:
            return "home/pre-certification"
        case .deletePreCertification(let id):
            return "home/pre-certification/\(id)"
        case .getFavoriteCertification:
            return "home/favorite"
        case .getMonthlyPreCertification:
            return "home/pre-certification/month"
        case .getDailyPreCertification:
            return "home/pre-certification/day"
        case .addPreCertification:
            return "home/pre-certification"
        case .editPreCertification(_, id: let id):
            return "home/pre-certification/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPreCertification:
            return .get
        case .deletePreCertification:
            return .delete
        case .getFavoriteCertification:
            return .get
        case .addPreCertification:
            return .post
        case .getMonthlyPreCertification:
            return .get
        case .getDailyPreCertification:
            return .get
        case .editPreCertification:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPreCertification:
            return .requestPlain
        case .deletePreCertification:
            return .requestPlain
        case .getFavoriteCertification:
            return .requestPlain
        case .getMonthlyPreCertification(let year, let month):
            return .requestParameters(
                parameters: [
                    "year": "\(year)",
                    "month": "\(month)"],
                encoding: URLEncoding.queryString
            )
        case .getDailyPreCertification(let date):
            return .requestParameters(
                parameters: ["date": "\(date)"],
                encoding: URLEncoding.queryString
            )
        case .addPreCertification(let request):
            return .requestJSONEncodable(request)
        case .editPreCertification(let request, _):
            return .requestJSONEncodable(request)
        }
    }
    
}
