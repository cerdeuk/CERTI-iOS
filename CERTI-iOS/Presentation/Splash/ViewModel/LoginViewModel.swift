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
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Login")

    @Published var isLoginSuccess = false
    @Published var errorMessage: String?

    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 앱이 설치되어 있으면 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk { [weak self] oAuthToken, error in
                self?.handleLoginResult(oAuthToken: oAuthToken, error: error)
            }
        } else {
            // 아니면 웹 브라우저로 로그인
            UserApi.shared.loginWithKakaoAccount { [weak self] oAuthToken, error in
                self?.handleLoginResult(oAuthToken: oAuthToken, error: error)
            }
        }
    }

    private func handleLoginResult(oAuthToken: OAuthToken?, error: Error?) {
        if let error = error {
            print("❌ 로그인 실패: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
            return
        }

        guard let token = oAuthToken?.accessToken else {
            print("❌ 토큰 없음")
            self.errorMessage = "토큰 없음"
            return
        }

        print("✅ 로그인 성공! AccessToken: \(token)")
        self.isLoginSuccess = true
    }
    
    
}
