//
//  AuthAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

import Moya

enum AuthAPI {
    case login(type: String, accessToken: String)
    case signUp(request: SignupRequestDTO, preSignUpToken: String)
    case logout
    case refresh
    case withDraw
}

extension AuthAPI: BaseTargetType {
    var headerType: HeaderType {
        switch self {
        case .login:
            return .noneHeader
        case .refresh:
            return .refreshTokenHeader
        case .logout, .withDraw:
            return .accessTokenHeader
        case .signUp:
            return .noneHeader
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth/sign-in"
        case .refresh:
            return "auth/reissue"
        case .logout:
            return "로그아웃 주소"
        case .withDraw:
            return "auth/withdraw"
        case .signUp:
            return "auth/sign-up"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .refresh:
            return .get
        case .withDraw:
            return .delete
        case .signUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(type, accessToken):
            let bodyParameters: [String: Any] = [
                "accessToken": accessToken,
                "socialType": type
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .refresh:
            return .requestPlain
        case .logout:
            return .requestPlain
        case .withDraw:
            return .requestPlain
        case .signUp(let request, _):
            return .requestJSONEncodable(request)
        }
    }
    
}
