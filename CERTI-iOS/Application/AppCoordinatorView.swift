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
            OnboardingUnivView()
                .environmentObject(appCoordinator)
        case .auth:
            LoginView()
                .environmentObject(appCoordinator)
        case .main:
            CertiTabBarCoordinatorView(tabCoordinator: appCoordinator.tabCoordinator)
                .environmentObject(appCoordinator.tabCoordinator)
        }
    }
}
