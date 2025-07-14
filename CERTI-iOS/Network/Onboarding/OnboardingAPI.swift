//
//  OnboardingAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

import Moya

enum OnboardingAPI {
    case searchUniv(keyword: String, preSignUpToken: String)
    case searchMajor(keyword: String, preSignUpToken: String)
}

extension OnboardingAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        default:
            return .noneHeader
        }
    }
    
    var path: String {
        switch self {
        case .searchUniv:
            return "university/search"
        case .searchMajor:
            return "major/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .searchUniv(let keyword, _):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)

        case .searchMajor(let keyword, _):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)
        }
    }
    
}
