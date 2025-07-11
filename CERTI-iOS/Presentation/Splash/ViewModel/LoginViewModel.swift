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
    
    //MARK: - Property Wrappers
    
    @Published var isLoginSuccess = false
    
    //MARK: - Properties
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Login")
    private let authService = NetworkService.shared.authService
    
    //MARK: - Func
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    //MARK: - Private Func
    
    // 카카오톡 앱으로 로그인
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] oAuthToken, error in
            self?.handleKakaoLoginResult(oAuthToken: oAuthToken, error: error)
        }
    }
    
    //카카오톡 웹으로 로그인
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oAuthToken, error in
            self?.handleKakaoLoginResult(oAuthToken: oAuthToken, error: error)
        }
    }
    
    private func handleKakaoLoginResult(oAuthToken: OAuthToken?, error: Error?) {
        if let error = error {
            logger.error("❌ 카카오 로그인 실패: \(error.localizedDescription)")
            return
        }
        
        guard let accessToken = oAuthToken?.accessToken else {
            logger.error("❌ 카카오 토큰 없음")
            return
        }
        
        logger.info("✅ 카카오 로그인 성공, AccessToken: \(accessToken)")
        
        Task {
            await handleServerLogin(with: accessToken)
        }
    }
    
    private func handleServerLogin(with accessToken: String) async {
        let result = await authService.login(type: .kakao, authorizationCode: accessToken)
        
        switch result {
        case .success(let authResponse):
            handleAuthResponse(authResponse)
        case .failure(let error):
            logger.error("❌ 서버 로그인 실패: \(error.localizedDescription)")
        }
    }
    
    private func handleAuthResponse(_ authResponse: AuthResponse) {
        switch authResponse {
        case .success(let loginDTO):
            logger.info("✅ 서버 로그인 성공, 유저 ID: \(loginDTO.userId)")
            Task {
                saveTokens(from: loginDTO)
                self.isLoginSuccess = true
            }
        case .needSignUp(let signupDTO):
            logger.info("🔁 회원가입 필요: \(signupDTO.userInformation.nickname)")
            self.isLoginSuccess = true
        }
    }
    
    private func saveTokens(from dto: LoginSuccessResponseDTO) {
        guard let token = dto.tokenResponse else {
            logger.error("❌ 토큰 응답 누락")
            return
        }
        _ = TokenManager.shared.saveTokens(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }
}
