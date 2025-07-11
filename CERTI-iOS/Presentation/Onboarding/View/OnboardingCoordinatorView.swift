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
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            OnboardingUnivView(viewModel: viewModel)
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .grade:
                        OnboardingGradeView(selectedGrade: $viewModel.selectedGrade)
                            .navigationBarBackButtonHidden()

                    case .track:
                        OnboardingTrackView(selectedtrack: $viewModel.selectedTrack)
                            .navigationBarBackButtonHidden()

                    case .major:
                        OnboardingMajorView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()

                    case .jobCategory:
                        OnboardingJobCategoryView()
                            .navigationBarBackButtonHidden()

                    case .info:
                        OnboardingInfoView()
                            .navigationBarBackButtonHidden()

                    }
                }
        }
        .environmentObject(onboardingCoordinator)
    }
}
