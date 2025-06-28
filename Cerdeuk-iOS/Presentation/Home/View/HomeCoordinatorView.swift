//
//  HomeCoordinatorView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject var homeCoordinator: HomeCoordinator
    
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView()
                .navigationDestination(for: HomeRoute.self) { route in
                    switch route {
                    case .detail:
                        HomeDetailView()
                    }
                }
        }
        .environmentObject(homeCoordinator)
    }
}
