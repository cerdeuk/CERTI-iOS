//
//  UserAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

enum UserAPI {
    case getUserInfo
    case checkNickname(nickname: String)
    case getMyPageInfo
    case getEditProfileInfo
    case putEditProfileInfo(request: EditProfileRequestDTO)
    case searchUniv(keyword: String)
    case searchMajor(keyword: String)
}

extension UserAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .getUserInfo:
            return .accessTokenHeader
        case .checkNickname:
            return .accessTokenHeader
        default:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getUserInfo:
            return "user"
        case .checkNickname:
            return "user/validation"
        case .getMyPageInfo:
            return "user/mypage"
        case .getEditProfileInfo:
            return "user/pinfo"
        case .putEditProfileInfo:
            return "user/pinfo"
        case .searchUniv:
            return "university/search"
        case .searchMajor:
            return "major/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo:
            return .get
        case .checkNickname:
            return .get
        case .getMyPageInfo:
            return .get
        case .getEditProfileInfo:
            return .get
        case .putEditProfileInfo:
            return .put
        case .searchUniv:
            return .get
        case .searchMajor:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserInfo:
            return .requestPlain
        case .checkNickname(nickname: let nickname):
            return .requestParameters(
                parameters: ["keyword": nickname],
                encoding: URLEncoding.queryString
            )
        case .getMyPageInfo:
            return .requestPlain
        case .getEditProfileInfo:
            return .requestPlain
        case .putEditProfileInfo(let request):
            return .requestJSONEncodable(request)
            
        case .searchUniv(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)

        case .searchMajor(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)
        }
    }
    
}
