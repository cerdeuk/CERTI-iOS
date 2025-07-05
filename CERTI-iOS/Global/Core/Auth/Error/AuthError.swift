//
//  AuthError.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

enum AuthError: Error {
    case loginFailed/*(service: SocialLoginType)*/
    case logoutFailed/*(service: SocialLoginType)*/
    case notLoggedIn
    case tokenNotFound
    case keychainError
    case invalidResponse
    case networkError
    
    var message: String {
        switch self {
        case .loginFailed/*(let service)*/:
            return "로그인에 실패했습니다"
        case .logoutFailed/*(let service)*/:
            return "로그아웃에 실패했습니다"
        case .notLoggedIn:
            return "로그인이 필요합니다"
        case .tokenNotFound:
            return "인증 정보를 찾을 수 없습니다"
        case .keychainError:
            return "보안 저장소 접근에 실패했습니다"
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다"
        case .networkError:
            return "네트워크 오류가 발생했습니다"
        }
    }
}
