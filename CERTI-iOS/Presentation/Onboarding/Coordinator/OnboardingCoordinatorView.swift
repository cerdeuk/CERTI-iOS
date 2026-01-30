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
                .onChange(of: onboardingViewModel.onboardingViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .navigateToGrade:
                        onboardingCoordinator.push(next: .grade)
                    case .navigateToTrack:
                        onboardingCoordinator.push(next: .track)
                    case .navigateToMajor:
                        onboardingCoordinator.push(next: .major)
                    case .navigateToJobCategory:
                        onboardingCoordinator.push(next: .jobCategory)
                    case .navigateToNickName:
                        onboardingCoordinator.push(next: .nickname)
                    case .navigateToInfo:
                        onboardingCoordinator.push(next: .info)
                    case .onboardingViewRoutePop:
                        onboardingCoordinator.pop()
                    case .completeOnboardingKakao:
                        appCoordinator.completeOnboardingKakao()
                        onboardingCoordinator.reset()
                        
                    case .completeOnboardingApple:
                        appCoordinator.completeOnboardingApple()
                        onboardingCoordinator.reset()
                        
                    case .onboardingViewRouteReset:
                        onboardingCoordinator.reset()
                        
                    case .cancelOnboarding:
                        appCoordinator.cancelOnboarding()
                        onboardingCoordinator.reset()
                    }
                    onboardingViewModel.onboardingViewRoute = nil
                }
                .navigationDestination(for: OnboardingRoute.self) { route in
                    switch route {
                    case .grade:
                        OnboardingGradeView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .track:
                        OnboardingTrackView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .major:
                        OnboardingMajorView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .jobCategory:
                        OnboardingJobCategoryView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .nickname:
                        OnboardingNickNameView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .info:
                        OnboardingInfoView(viewModel: onboardingViewModel)
                            .navigationBarBackButtonHidden()
                        
                    }
                }
        }
    }
}
