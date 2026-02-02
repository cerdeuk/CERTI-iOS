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
                .navigationBarHidden(true)
                .onChange(of: certificateViewModel.certificateViewRoute) { route in
                    guard let route = route else { return }
                    
                    switch route {
                    case .certificateViewRoutePop:
                        certificateCoordinator.pop()
                        
                    case .navigateTojobList:
                        certificateCoordinator.push(next: .jobList)
                        
                    case .navigateTotrackList:
                        certificateCoordinator.push(next: .trackList)
                        
                    case .navigateToSearch:
                        certificateCoordinator.push(next: .search)
                        
                    default: certificateCoordinator.reset()
                    }
                    
                    certificateViewModel.certificateViewRoute = nil
                }
                .navigationDestination(for: CertificateRoute.self) { route in
                    switch route {
                    case .jobList:
                        CertificateListView(viewModel: certificateViewModel, viewType: .job)
                            .navigationBarHidden(true)
                        
                    case .trackList:
                        CertificateListView(viewModel: certificateViewModel, viewType: .track)
                            .navigationBarHidden(true)
                        
                    case .search:
                        CertificateSearchView(viewModel: certificateViewModel)
                            .navigationBarHidden(true)

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
