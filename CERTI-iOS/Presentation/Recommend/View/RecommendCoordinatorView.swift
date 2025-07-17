//
//  RecommendCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator

    @ObservedObject var recommendCoordinator: RecommendCoordinator
    @StateObject var recommendViewModel = RecommendViewModel()

    var body: some View {
        NavigationStack(path: $recommendCoordinator.path) {
            RecommendView(viewModel: recommendViewModel)
                .navigationDestination(for: RecommendRoute.self) { route in
                    switch route {
                    case .detail:
                        CertificateDetailView(certificationId: $recommendViewModel.selectedCertificateId, beforeViewType: .recommend)
                    }
                }
        }
        .environmentObject(recommendCoordinator)
        .onChange(of: recommendCoordinator.path) { value in
            if value.isEmpty {
                tabCoordinator.isTabBarHidden = false
            } else {
                tabCoordinator.isTabBarHidden = true
            }
        }
        .onChange(of: recommendViewModel.isShowLoading) { loadingState in
            if loadingState {
                tabCoordinator.isTabBarHidden = true
            } else {
                tabCoordinator.isTabBarHidden = false
            }
        }
    }
}
