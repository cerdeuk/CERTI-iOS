//
//  OnboardingUnivView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct OnboardingUnivView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator

    var body: some View {
        VStack {
            Text("온보딩 화면")
            Button("온보딩 완료") {
                appCoordinator.completeOnboarding()
            }
        }
    }
}

#Preview {
    OnboardingUnivView()
        .environmentObject(AppCoordinator())
}
