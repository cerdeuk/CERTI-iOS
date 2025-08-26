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
    @StateObject var certificateDetailViewModel: CertificateDetailViewModel
    
    private let categoryFactory: CategoryFactory
    private let certificateDetailFactory: CertificateDetailFactory
    
    init(categoryCoordinator: CategoryCoordinator, categoryFactory: CategoryFactory, certificateDetailFactory: CertificateDetailFactory) {
        self.categoryCoordinator = categoryCoordinator
        self.categoryFactory = categoryFactory
        _categoryViewModel = StateObject(wrappedValue: categoryFactory.makeCategoryViewModel())
        self.certificateDetailFactory = certificateDetailFactory
        _certificateDetailViewModel = StateObject(wrappedValue: certificateDetailFactory.makeCertificateDetailViewModel())
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
                    case .certificateDetail: CertificateDetailView(viewModel: certificateDetailViewModel, certificationId: $categoryViewModel.selectedCertificateId) {
                        categoryCoordinator.pop()
                    }
                    }
                }
        }

        .environmentObject(categoryCoordinator)
        .onChange(of: categoryCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}
