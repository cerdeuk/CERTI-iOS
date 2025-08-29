//
//  HomeCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator
    
    @ObservedObject var homeCoordinator: HomeCoordinator
    
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject var certificateDetailViewModel: CertificateDetailViewModel
    
    private let homeFactory: HomeFactory
    private let certificateDetailFactory: CertificateDetailFactory
    
    init(homeCoordinator: HomeCoordinator, homeFactory: HomeFactory, certificateDetailFactory: CertificateDetailFactory) {
        self.homeCoordinator = homeCoordinator
        self.homeFactory = homeFactory
        _homeViewModel = StateObject(wrappedValue: homeFactory.makeHomeViewModel())
        self.certificateDetailFactory = certificateDetailFactory
        _certificateDetailViewModel = StateObject(wrappedValue: certificateDetailFactory.makeCertificateDetailViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(viewModel: homeViewModel)
                .onChange(of: homeViewModel.homeViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .switchToRecommendTab:
                        tabCoordinator.switchTab(tab: .recommend)
                    case .withDraw:
                        appCoordinator.withDraw()
                    case .navigateToCertificateDetail:
                        homeCoordinator.push(next: .certificateDetail)
                    case .navigateToPreLicenseEdit:
                        homeCoordinator.push(next: .preLicenseEdit)
                    case .homeViewRoutePop:
                        homeCoordinator.pop()
                    }
                    homeViewModel.homeViewRoute = nil
                }
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .preLicenseEdit:
                        PreLicenseEditView(viewModel: homeViewModel)
                            .navigationBarBackButtonHidden()
                    case .certificateDetail:
                        CertificateDetailView(viewModel: certificateDetailViewModel, certificationId: $homeViewModel.selectedLicenseId) {
                            homeCoordinator.pop()
                        }
                    }
                }
        }
        .environmentObject(homeCoordinator)
        .onChange(of: homeCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}
