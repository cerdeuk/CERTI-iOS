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
    
    private let kakaoLoginUseCase: KakaoLoginUseCase
    
    //MARK: - init
    
    init(kakaoLoginUseCase: KakaoLoginUseCase) {
        self.kakaoLoginUseCase = kakaoLoginUseCase
    }
    
    //MARK: - Property Wrappers

    @State private var accessToken: String? = ""
    @State private var socialType: String? = ""
    
    //MARK: - Func

    func kakaoLoginButtonTapped() async -> Bool {
        logger.info("카카오 로그인 시작")
        
        let result = await kakaoLogin()
        
        switch result {
        case .success(let accessToken):
            return await handleServerLogin(with: accessToken)
        case .failure(let error):
            logger.error("로그인 실패: \(String(describing: error))")
            return false
        }
    }
    
}

// MARK: - Kakao Login

extension LoginViewModel {
    private func kakaoLogin() async -> Result<String, AuthError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return await loginWithKakaoTalk()
        } else {
            return await loginWithKakaoAccount()
        }
    }
    
    private func loginWithKakaoTalk() async -> Result<String, AuthError> {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    self.logger.error("❌ KakaoTalk login failed: \(error.localizedDescription)")
                    continuation.resume(returning: .failure(.loginFailed))
                    return
                }
                
                guard let accessToken = oauthToken?.accessToken else {
                    self.logger.error("❌ KakaoTalk login failed: missing accessToken")
                    continuation.resume(returning: .failure(.loginFailed))
                    return
                }
                
                self.logger.info("✅ KakaoTalk login succeeded")
                continuation.resume(returning: .success(accessToken))
            }
        }
    }
    
    private func loginWithKakaoAccount() async -> Result<String, AuthError> {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    self.logger.error("❌ KakaoAccount login failed: \(error.localizedDescription)")
                    continuation.resume(returning: .failure(.loginFailed))
                    return
                }
                
                guard let accessToken = oauthToken?.accessToken else {
                    self.logger.error("❌ KakaoAccount login failed: missing accessToken")
                    continuation.resume(returning: .failure(.loginFailed))
                    return
                }
                
                self.logger.info("✅ KakaoAccount login succeeded")
                continuation.resume(returning: .success(accessToken))
            }
        }
    }
}


// MARK: - Server Login

extension LoginViewModel {
    private func handleServerLogin(with accessToken: String) async -> Bool {
        
        let result = await kakaoLoginUseCase.execute(type: "KAKAO", accessToken: accessToken)
        
        switch result {
        case .success(let authResponse):
            return handleAuthResponse(authResponse)
        case .failure(let error):
            logger.error("❌ 서버 로그인 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    private func handleAuthResponse(_ authResponse: LoginResponseEntity) -> Bool {
        switch authResponse.needSignUp {
        case true:
            logger.info("✅ 서버 로그인 성공, 유저 ID: \(authResponse.userInformation.socialID)")
            saveTokens(from: authResponse)
            AuthManager.shared.temporarySignUpData = authResponse
            return true
        case false:
            logger.info("🔁 회원가입 필요, 유저 ID: \(authResponse.userInformation.socialID)")
            saveTokens(from: authResponse)
            AuthManager.shared.temporarySignUpData = authResponse
            return false
        }
    }

    private func saveTokens(from entity: LoginResponseEntity) {
        _ = TokenManager.shared.saveTokens(
            accessToken: entity.preSignupToken,
            refreshToken: entity.preSignupToken
        )
    }

}

