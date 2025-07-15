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
    @StateObject var viewModel = RecommendViewModel()

    var body: some View {
        NavigationStack(path: $recommendCoordinator.path) {
            RecommendView(viewModel: viewModel)
                .navigationDestination(for: RecommendRoute.self) { route in
                    switch route {
                    case .detail:
                        CertificateDetailView(viewmodel: viewModel)
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
    }
}
