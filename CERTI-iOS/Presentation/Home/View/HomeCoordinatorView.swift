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
    
    init(homeCoordinator: HomeCoordinator) {
        let factory = AppDIContainer.shared.makeHomeFactory()
        _homeViewModel = StateObject(wrappedValue: factory.makeHomeViewModel())
        self.homeCoordinator = homeCoordinator
    }
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(viewModel: homeViewModel)
                .onChange(of: homeViewModel.route) { route in
                    if let route = route {
                        homeCoordinator.push(next: route)
                        homeViewModel.route = nil
                    }
                }
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .preLicenseEdit:
                        PreLicenseEditView(viewModel: homeViewModel)
                            .navigationBarBackButtonHidden()
                    case .certificateDetail:
                        CertificateDetailView(certificationId: $homeViewModel.selectedLicenseId, beforeViewType: .home)
                    }
                }
        }
        .environmentObject(homeCoordinator)
        .onChange(of: homeCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}
