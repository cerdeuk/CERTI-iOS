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
    
    @StateObject var categoryViewModel: CategoryViewModel
    
    private let categoryFactory: CategoryFactory
    
    init(categoryCoordinator: CategoryCoordinator, categoryFactory: CategoryFactory) {
        self.categoryCoordinator = categoryCoordinator
        self.categoryFactory = categoryFactory
        _categoryViewModel = StateObject(wrappedValue: categoryFactory.makeCategoryViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $categoryCoordinator.path) {
            CategoryView(viewModel: categoryViewModel)
                .onChange(of: categoryViewModel.categoryViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .navigateToSearch: categoryCoordinator.push(next: .search)
                    case .navigateToCertificateDetail: categoryCoordinator.push(next: .certificateDetail)
                    case .categoryViewRoutePop: categoryCoordinator.pop()
                    }
                    categoryViewModel.categoryViewRoute = nil
                }
                .navigationDestination(for: CategoryRoute.self) { route in
                    switch route {
                    case .search: CategorySearchView(viewModel: categoryViewModel)
                    case .certificateDetail: CertificateDetailView(certificationId: $categoryViewModel.selectedCertificateId, beforeViewType: .category)
                    }
                }
        }

        .environmentObject(categoryCoordinator)
        .onChange(of: categoryCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}
