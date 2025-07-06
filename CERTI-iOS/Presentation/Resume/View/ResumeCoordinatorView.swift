//
//  ResumeCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

struct ResumeCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator

    @ObservedObject var resumeCoordinator: ResumeCoordinator
    
    var body: some View {
        NavigationStack(path: $resumeCoordinator.path) {
            ResumeView()
                .navigationDestination(for: ResumeRoute.self) { route in
                    switch route {
                    case .detail:
                        ResumeDetailView()
                    }
                }
        }
        .environmentObject(resumeCoordinator)
        .onChange(of: resumeCoordinator.path) { value in
            if value.isEmpty {
                tabCoordinator.isTabBarHidden = false
            } else {
                tabCoordinator.isTabBarHidden = true
            }
        }
    }
}
