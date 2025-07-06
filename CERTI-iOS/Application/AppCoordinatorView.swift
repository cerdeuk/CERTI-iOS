//
//  AppCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some View {
        switch appCoordinator.appState {
        case .splash:
            SplashView()
        case .onboarding:
            OnboardingView {
                appCoordinator.completeOnboarding()
            }
        case .auth:
            LoginView()
//            LoginView {
//                appCoordinator.completeLogin()
//            }
        case .main:
            CDTabBarCoordinatorView(tabCoordinator: appCoordinator.tabCoordinator)
                .environmentObject(appCoordinator.tabCoordinator)
        }
    }
}
