//
//  AppCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    
    private let appDIContainer = AppDIContainer.shared

    var body: some View {
        switch appCoordinator.appState {
        case .splash:
            SplashView()
        case .onboarding:
            OnboardingCoordinatorView(onboardingCoordinator: appCoordinator.onboardingCoordinator, onboardingFactory: appDIContainer.makeOnboardingFactory())
                .environmentObject(appCoordinator)
        case .auth:
            LoginView()
                .environmentObject(appCoordinator)
        case .main:
            CertiTabBarCoordinatorView(tabCoordinator: appCoordinator.tabCoordinator, appDIContainer: appDIContainer)
                .environmentObject(appCoordinator)
        }
    }
}
