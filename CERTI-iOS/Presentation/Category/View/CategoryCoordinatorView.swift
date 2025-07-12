//
//  CategoryCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

struct CategoryCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator

    @ObservedObject var categoryCoordinator: CategoryCoordinator
    @StateObject var categoryViewModel = CategoryViewModel()
    
    var body: some View {
        NavigationStack(path: $categoryCoordinator.path) {
            CategoryView(viewModel: categoryViewModel)
                .navigationDestination(for: CategoryRoute.self) { route in
                    switch route {
                    case .detail:
                        CategorySearchView(viewModel: categoryViewModel)
                    }
                }
        }

        .environmentObject(categoryCoordinator)
        .onChange(of: categoryCoordinator.path) { value in
            if value.isEmpty {
                tabCoordinator.isTabBarHidden = false
            } else {
                tabCoordinator.isTabBarHidden = true
            }
        }
    }
}
