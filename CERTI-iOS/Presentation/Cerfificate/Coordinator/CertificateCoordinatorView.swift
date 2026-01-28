//
//  CertificateCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct CertificateCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator

    @ObservedObject var certificateCoordinator: CertificateCoordinator
    
    @StateObject var certificateViewModel: CertificateViewModel
    
    private let certificateFactory: CertificateFactory
    
    init(certificateCoordinator: CertificateCoordinator, certificateFactory: CertificateFactory) {
        self.certificateCoordinator = certificateCoordinator
        self.certificateFactory = certificateFactory
        _certificateViewModel = StateObject(wrappedValue: certificateFactory.makeCertificateViewModel())
    }

    
    var body: some View {
        NavigationStack(path: $certificateCoordinator.path) {
            CertificateView(viewModel: certificateViewModel)
                .onChange(of: certificateViewModel.certificateViewRoute) { route in
                    guard let route = route else { return }
                    
                    // 코디네이터 path 추가
                    switch route {

                        
                    default: certificateCoordinator.reset()
                    }
                    
                    certificateViewModel.certificateViewRoute = nil
                }
                .navigationDestination(for: CertificateRoute.self) { route in
                    switch route {

                        // 실질 화면전환
                    default: EmptyView()
                    }
                }
        }
        .environmentObject(certificateCoordinator)
        .onChange(of: certificateCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}
