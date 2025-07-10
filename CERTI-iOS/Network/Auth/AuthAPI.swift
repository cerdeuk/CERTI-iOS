//
//  AuthAPI.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

import Moya

enum AuthAPI {
    case login(type: SocialLoginType, code: String)
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
        case .logout:
            return .accessTokenHeader
        case .withDraw:
            return .accessTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case let .login(type, _):
            return type.loginPath
        case .refresh:
            return "리프레쉬토큰 요청 주소"
        case .logout:
            return "로그아웃 주소"
        case .withDraw:
            return "회원 탈퇴 주소"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(type, code):
            let bodyParameters: [String: Any] = [
                type.authorizationQueryKey: code,
                "socialType": type.rawValue
            ]
            return .requestParameters(parameters: bodyParameters, encoding: JSONEncoding.default)
        case .refresh:
            return .requestPlain
        case .logout:
            return .requestPlain
        case .withDraw:
            return .requestPlain
        }
    }
}
