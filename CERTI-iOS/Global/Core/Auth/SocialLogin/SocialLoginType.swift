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
        case .kakao: return "Kakao"
        case .apple: return "Apple"
        }
    }
    
    var loginPath: String {
        switch self {
        case .kakao: return "카카오 로그인 주소"
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
