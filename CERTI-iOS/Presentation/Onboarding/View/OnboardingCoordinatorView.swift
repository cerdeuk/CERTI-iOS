//
//  OnboardingCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator

    @ObservedObject var onboardingCoordinator: OnboardingCoordinator
    
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            OnboardingUnivView()
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .grade:
                        OnboardingGradeView()
                    case .track:
                        OnboardingTrackView()
                    case .major:
                        OnboardingMajorView()
                    case .jobCategory:
                        OnboardingJobCategoryView()
                    case .info:
                        OnboardingInfoView()
                    }
                }
        }
        .environmentObject(onboardingCoordinator)
    }
}
