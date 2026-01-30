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
    case didOnboard
    
    var description: String {
        switch self {
        case .didOnboard:
            return "didOnboard"
        }
    }
    
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
        let didOnboard = UserDefaults.standard.bool(forKey: DidOnboard.didOnboard.description)
        
        await MainActor.run {
            switch tokenResult {
            case .success:
                appState = didOnboard ? .main : .auth
            case .failure:
                appState = .auth
            }
        }
    }
    
    /// 로그인 완료 시 호출
    func completeLogin() {
        let didOnboard = UserDefaults.standard.bool(forKey: DidOnboard.didOnboard.description)
        appState = didOnboard ? .main : .onboarding
    }
    
    /// 온보딩 완료 시 호출
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: DidOnboard.didOnboard.description)
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
        UserDefaults.standard.removeObject(forKey: DidOnboard.didOnboard.description)
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
