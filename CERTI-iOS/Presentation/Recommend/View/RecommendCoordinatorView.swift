//
//  RecommendCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CDTabCoordinator

    @ObservedObject var recommendCoordinator: RecommendCoordinator
    
    var body: some View {
        NavigationStack(path: $recommendCoordinator.path) {
            RecommendView()
                .navigationDestination(for: RecommendRoute.self) { route in
                    switch route {
                    case .detail:
                        RecommendDetailView()
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
