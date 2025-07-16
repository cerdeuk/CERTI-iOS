//
//  AuthManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/13/25.
//

import SwiftUI

import KakaoSDKUser
import KakaoSDKAuth
import os

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    private let authService = NetworkService.shared.authService

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Auth")

    var nickname: String = ""
    var needSignup: Bool = false
    private var email: String = ""
    private var profileImageUrl: String = ""
    private var preSignupToken: String = ""
    private var university: String = ""
    private var grade: String = ""
    private var track: String = ""
    private var major: String = ""
    private var jobs: [String] = []

    //MARK: - Func

    @MainActor
    func login(with type: SocialLoginType) async -> Result<Void, AuthError> {
        logger.debug("Starting login with \(type.serviceName)")

        //TODO: - 추후 애플로그인 추가예정
        let authResult = await kakaoLogin()
        
        switch authResult {
        case .success(let code):
            logger.debug("Received authorization code from \(type.serviceName)")
            return await handleServerLogin(with: code)
        case .failure(let error):
            logger.error("Social login failed: \(error)")
            return .failure(error)
        }
    }
    
    @MainActor
    func signUp() async -> Result<Void, AuthError> {
        logger.debug("Starting signUp")

        let signupRequest = SignupRequestDTO(
            userInformation: .init(
                email: email,
                nickname: nickname,
                profileImageUrl: profileImageUrl
            ),
            university: university,
            grade: grade,
            track: track,
            major: major,
            jobs: jobs
        )

        let result = await authService.signUp(
            request: signupRequest,
            preSignUpToken: preSignupToken
        )
        
        switch result {
        case .success(let dto):
            guard let data = dto.data else {
                logger.error("❌ 회원가입 응답 데이터 없음")
                return .failure(.networkError)
            }

            logger.info("✅ 회원가입 성공, 유저 ID: \(data.userId)")

            let accessToken = data.jwtResponse.accessToken
            let refreshToken = data.jwtResponse.refreshToken

            _ = TokenManager.shared.saveTokens(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
            return .success(())
        case .failure(let error):
            logger.error("❌ 회원가입 실패: \(error.localizedDescription)")
            return .failure(.networkError)
        }
    }
    
    @MainActor
    func applyOnboardingData(from viewModel: OnboardingViewModel) {
        self.university = viewModel.userUniversity
        self.grade = viewModel.selectedGrade
        self.track = viewModel.selectedTrack
        self.major = viewModel.userMajor
        self.jobs = viewModel.selectedJobCategory
    }
    
    func getPreSignupToken() -> String {
        preSignupToken
    }
    
    func cleanUserInfo() {
        nickname = ""
        email = ""
        profileImageUrl = ""
        preSignupToken = ""
        university = ""
        grade = ""
        track = ""
        major = ""
        jobs.removeAll()
    }
    
    //MARK: - Private Func
    
    private func saveUserInfo(from dto: SignupRequiredResponseDTO) {
        nickname = dto.userInformation.nickname
        email = dto.userInformation.email
        profileImageUrl = dto.userInformation.profileImageUrl
        preSignupToken = dto.preSignupToken
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

// MARK: - Kakao Login

extension AuthManager {
    @MainActor
    private func kakaoLogin() async -> Result<String, AuthError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return await loginWithKakaoTalk()
        } else {
            return await loginWithKakaoAccount()
        }
    }
    
    @MainActor
    private func loginWithKakaoTalk() async -> Result<String, AuthError> {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    self.logger.error("❌ KakaoTalk login failed: \(error.localizedDescription)")
                    continuation.resume(returning: .failure(.loginFailed(service: .kakao)))
                    return
                }
                
                guard let authCode = oauthToken?.accessToken else {
                    self.logger.error("❌ KakaoTalk login failed: missing accessToken")
                    continuation.resume(returning: .failure(.loginFailed(service: .kakao)))
                    return
                }
                
                self.logger.info("✅ KakaoTalk login succeeded")
                continuation.resume(returning: .success(authCode))
            }
        }
    }
    
    @MainActor
    private func loginWithKakaoAccount() async -> Result<String, AuthError> {
        return await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    self.logger.error("❌ KakaoAccount login failed: \(error.localizedDescription)")
                    continuation.resume(returning: .failure(.loginFailed(service: .kakao)))
                    return
                }
                
                guard let authCode = oauthToken?.accessToken else {
                    self.logger.error("❌ KakaoAccount login failed: missing accessToken")
                    continuation.resume(returning: .failure(.loginFailed(service: .kakao)))
                    return
                }
                
                self.logger.info("✅ KakaoAccount login succeeded")
                continuation.resume(returning: .success(authCode))
            }
        }
    }
}

// MARK: - Server Login

extension AuthManager {
    @MainActor
    private func handleServerLogin(with accessToken: String) async -> Result<Void, AuthError> {
        let result = await authService.login(type: .kakao, authorizationCode: accessToken)
        
        switch result {
        case .success(let authResponse):
            return handleAuthResponse(authResponse)
        case .failure(let error):
            logger.error("❌ 서버 로그인 실패: \(error.localizedDescription)")
            return .failure(.networkError)
        }
    }
    
    @MainActor
    private func handleAuthResponse(_ authResponse: AuthResponse) -> Result<Void, AuthError> {
        switch authResponse {
        case .success(let loginDTO):
            logger.info("✅ 서버 로그인 성공, 유저 ID: \(loginDTO.userId)")
            Task {
                saveTokens(from: loginDTO)
            }
            needSignup = loginDTO.needSignUp
            return .success(())
            
        case .needSignUp(let signupDTO):
            logger.info("🔁 회원가입 필요: \(signupDTO.userInformation.nickname)")
            Task {
                saveUserInfo(from: signupDTO)
            }
            return .success(())
        }
    }

}
