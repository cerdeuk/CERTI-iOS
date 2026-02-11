//
//  AppCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI
import Combine

enum AppRoute {
    case splash
    case onboarding
    case auth
    case main
}

enum DidOnboard {
    case didOnboardKakao
    case didOnboardApple
    
    var description: String {
        switch self {
        case .didOnboardKakao:
            return "didOnboardKakao"
        case .didOnboardApple:
            return "didOnboardApple"
        }
    }
}

enum SocialType {
    case kakao
    case apple
}

final class AppCoordinator: ObservableObject {
    @Published var appState: AppRoute = .splash
    let tabCoordinator = CertiTabCoordinator()
    let onboardingCoordinator = OnboardingCoordinator()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        //                #if DEBUG
        //                TokenManager.shared.clearTokens()
        //                UserDefaults.standard.removeObject(forKey: "DidOnboard.didOnboard.description")
        //                print("[DEBUG] Keychain cleared for login testing")
        //                #endif
        tokenExpiredbind()
        
        Task {
            await start()
        }
    }
    
    private func start() async {
        try? await Task.sleep(for: .seconds(2)) // Splash 대기 시간
        
        let tokenResult = TokenManager.shared.getAccessToken()
        
        let isKakaoMember = UserDefaults.standard.bool(forKey: DidOnboard.didOnboardKakao.description)
        let isAppleMember = UserDefaults.standard.bool(forKey: DidOnboard.didOnboardApple.description)
        
        let isMember = isKakaoMember || isAppleMember
        
        await MainActor.run {
            switch tokenResult {
            case .success:
                if isMember {
                    appState = .main
                } else {
                    appState = .auth
                }
                
            case .failure:
                // 토큰 없음 -> Auth
                appState = .auth
            }
        }
    }
    
    func loginAsExistingUser(type: SocialType) {
        switch type {
        case .kakao:
            UserDefaults.standard.set(true, forKey: DidOnboard.didOnboardKakao.description)
        case .apple:
            UserDefaults.standard.set(true, forKey: DidOnboard.didOnboardApple.description)
        }
        
        appState = .main
    }
    
    /// 신규 유저라서 온보딩이 필요할 때 호출
    func goToOnboarding() {
        appState = .onboarding
    }
    
    
    // MARK: - 온보딩 완료 처리
    
    /// 카카오 유저 온보딩 완료 시 호출
    func completeOnboardingKakao() {
        UserDefaults.standard.set(true, forKey: DidOnboard.didOnboardKakao.description)
        appState = .main
    }
    
    /// 애플 유저 온보딩 완료 시 호출
    func completeOnboardingApple() {
        UserDefaults.standard.set(true, forKey: DidOnboard.didOnboardApple.description)
        appState = .main
    }
    
    func cancelOnboarding() {
        appState = .auth
    }
    
    /// 로그아웃 시
    func logout() {
        _ = TokenManager.shared.clearTokens()
        appState = .auth
    }
    
    func withDraw() {
        _ = TokenManager.shared.clearTokens()
        
        UserDefaults.standard.removeObject(forKey: DidOnboard.didOnboardKakao.description)
        UserDefaults.standard.removeObject(forKey: DidOnboard.didOnboardApple.description)
        
        appState = .auth
    }
}


// MARK: - 리프레쉬 토큰 만료 대응

private extension AppCoordinator {
    func tokenExpiredbind() {
        TokenRefresher.shared.tokenExpiredSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.logout()
            }
            .store(in: &cancellables)
    }
}
