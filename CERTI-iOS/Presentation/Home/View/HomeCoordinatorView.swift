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
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(viewModel: homeViewModel)
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .preLicenseEdit:
                        PreLicenseEditView(viewModel: homeViewModel)
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        .environmentObject(homeCoordinator)
        .onChange(of: homeCoordinator.path) { value in
            if value.isEmpty {
                tabCoordinator.isTabBarHidden = false
            } else {
                tabCoordinator.isTabBarHidden = true
            }
        }
    }
}
