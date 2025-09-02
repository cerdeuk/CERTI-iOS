//
//  LoginViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import SwiftUI

import KakaoSDKUser
import KakaoSDKAuth

import os

@MainActor
final class LoginViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Login")
    private let authManager = AuthManager.shared
    
    //MARK: - Func

    func kakaoLogin() async -> Bool {
        logger.info("카카오 로그인 시작")
        
        let result = await authManager.login(with: .kakao)
        
        switch result {
        case .success(let response):
            if response {
                UserDefaults.standard.set(true, forKey: "didOnboard")
            }
            return true
        case .failure(let error):
            logger.error("로그인 실패: \(String(describing: error))")
            return false
        }
    }
    
}
