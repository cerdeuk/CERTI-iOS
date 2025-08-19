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
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
        .onChange(of: recommendViewModel.isShowLoading) { loadingState in
            tabCoordinator.isTabBarHidden = loadingState
        }
    }
}
