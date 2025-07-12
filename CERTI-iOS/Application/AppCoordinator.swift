//
//  AppCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum AppRoute {
    case splash
    case onboarding
    case auth
    case main
}

final class AppCoordinator: ObservableObject {
    @Published var appState: AppRoute = .splash
    let tabCoordinator = CertiTabCoordinator()
    let onboardingCoordinator = OnboardingCoordinator()

    init() {
        #if DEBUG
        TokenManager.shared.clearTokens()
        UserDefaults.standard.removeObject(forKey: "didOnboard")
        print("[DEBUG] Keychain cleared for login testing")
        #endif
        
        Task {
            await start()
        }
    }

    private func start() async {
        try? await Task.sleep(for: .seconds(2)) // Splash 대기 시간

        let tokenResult = TokenManager.shared.getAccessToken()
        let didOnboard = UserDefaults.standard.bool(forKey: "didOnboard")

        await MainActor.run {
            switch tokenResult {
            case .success:
                appState = didOnboard ? .main : .onboarding
            case .failure:
                appState = .auth
            }
        }
    }

    /// 로그인 완료 시 호출
    func completeLogin() {
        let didOnboard = UserDefaults.standard.bool(forKey: "didOnboard")
        appState = didOnboard ? .main : .onboarding
    }

    /// 온보딩 완료 시 호출
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "didOnboard")
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
}
