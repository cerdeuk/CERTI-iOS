//
//  SocialLoginType.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/5/25.
//

import Foundation

enum SocialLoginType: String {
    case kakao = "KAKAO"
    case apple = "APPLE"
    
    var serviceName: String {
        switch self {
        case .kakao: return "kakao"
        case .apple: return "apple"
        }
    }
    
    var loginPath: String {
        switch self {
        case .kakao: return "auth/login"
        case .apple: return "애플 로그인 주소"
        }
    }
    
    var platform: String {
        switch self {
        case .kakao: return "WEB"
        case .apple: return "IOS"
        }
    }
    
    var authorizationQueryKey: String {
        switch self {
        case .kakao: return "accessToken"
        case .apple: return "authorizationCode"
        }
    }
    
    @MainActor
    func getAdapter() -> SocialLoginServiceProtocol {
        switch self {
        case .kakao: KakaoLoginAdapter()
        case .apple: AppleLoginAdapter()
        }
    }
}
