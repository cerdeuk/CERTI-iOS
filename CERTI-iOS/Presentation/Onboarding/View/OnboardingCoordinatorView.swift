//
//  OnboardingCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator

    @ObservedObject var onboardingCoordinator: OnboardingCoordinator
    
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            RecommendView()
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .univ:
                        OnboardingUnivView()
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
        .onChange(of: onboardingCoordinator.path) { value in
            if value.isEmpty {
                tabCoordinator.isTabBarHidden = false
            } else {
                tabCoordinator.isTabBarHidden = true
            }
        }
    }
}
