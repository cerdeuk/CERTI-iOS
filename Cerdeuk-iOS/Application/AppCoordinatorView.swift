//
//  AppCoordinatorView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        switch coordinator.appState {
        case .onboarding:
            OnboardingView()

        case .auth:
            OnboardingView()    // 추후 로그인뷰

        case .main:
            CDTabBarCoordinatorView(tabCoordinator: coordinator.tabRouter)
        }
    }
}
