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
    @StateObject var resumeViewModel = ResumeViewModel()
    
    var body: some View {
        NavigationStack(path: $resumeCoordinator.path) {
            ResumeView(viewModel: resumeViewModel)
                .navigationDestination(for: ResumeRoute.self) { route in
                    switch route {
                    case .myCertificateEdit:
                        MyCertificateEditView(viewModel: resumeViewModel)
                    case .myCareerEdit:
                        MyCareerEditView(viewModel: resumeViewModel)
                    case .myCareerWriteView:
                        MyCareerWriteView(viewModel: resumeViewModel)
                    case .myExtracurricularActivityEditView:
                        MyExtracurricularActivityEditView(viewModel: resumeViewModel)
                    case .myExtracurricularActivityWriteView:
                        MyExtracurricularActivityWriteView(viewModel: resumeViewModel)
                    }
                }
        }
        .environmentObject(resumeCoordinator)
        .onChange(of: resumeCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
        .onChange(of: resumeViewModel.isCardDetailPresented) { state in
            tabCoordinator.isTabBarHidden = state
        }
    }
}
