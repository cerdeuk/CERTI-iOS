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
    
    @StateObject private var onboardingViewModel: OnboardingViewModel
    
    private let onboardingFactory: OnboardingFactory

    init(onboardingCoordinator: OnboardingCoordinator, onboardingFactory: OnboardingFactory) {
        self.onboardingCoordinator = onboardingCoordinator
        self.onboardingFactory = onboardingFactory
        _onboardingViewModel = StateObject(wrappedValue: onboardingFactory.makeOnboardingViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            OnboardingUnivView(viewModel: onboardingViewModel)
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .grade:
                        OnboardingGradeView(selectedGrade: $onboardingViewModel.selectedGrade)
                            .navigationBarBackButtonHidden()

                    case .track:
                        OnboardingTrackView(selectedtrack: $onboardingViewModel.selectedTrack)
                            .navigationBarBackButtonHidden()

                    case .major:
                        OnboardingMajorView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()

                    case .jobCategory:
                        OnboardingJobCategoryView(selectedJobCategory: $onboardingViewModel.selectedJobCategory)
                            .navigationBarBackButtonHidden()

                    case .info:
                        OnboardingInfoView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()

                    }
                }
        }
        .environmentObject(onboardingCoordinator)
    }
}
