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
    
    @StateObject var recommendViewModel: RecommendViewModel
    @StateObject var certificateDetailViewModel: CertificateDetailViewModel
    
    private let recommendFactory: RecommendFactory
    private let certificateDetailFactory: CertificateDetailFactory
    
    init(recommendCoordinator: RecommendCoordinator, recommendFactory: RecommendFactory, certificateDetailFactory: CertificateDetailFactory) {
        self.recommendCoordinator = recommendCoordinator
        self.recommendFactory = recommendFactory
        _recommendViewModel = StateObject(wrappedValue: recommendFactory.makeRecommendViewModel())
        self.certificateDetailFactory = certificateDetailFactory
        _certificateDetailViewModel = StateObject(wrappedValue: certificateDetailFactory.makeCertificateDetailViewModel())
    }

    var body: some View {
        NavigationStack(path: $recommendCoordinator.path) {
            RecommendView(viewModel: recommendViewModel)
                .onChange(of: recommendViewModel.recommendViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .navigateToCertificateDetail:
                        recommendCoordinator.push(next: .certificateDetail)
                    case .recommendViewRoutePop: recommendCoordinator.pop()
                    }
                    recommendViewModel.recommendViewRoute = nil
                }
                .navigationDestination(for: RecommendRoute.self) { route in
                    switch route {
                    case .certificateDetail:
                        CertificateDetailView(viewModel: certificateDetailViewModel, certificationId: $recommendViewModel.selectedCertificateId) {
                            recommendCoordinator.pop()
                        }
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
