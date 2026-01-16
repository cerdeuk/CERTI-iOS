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
    @StateObject var resumeViewModel: ResumeViewModel
    
    private let resumeFactory: ResumeFactory
    
    init(resumeCoordinator: ResumeCoordinator, resumeFactory: ResumeFactory) {
        self.resumeCoordinator = resumeCoordinator
        self.resumeFactory = resumeFactory
        _resumeViewModel = StateObject(wrappedValue: resumeFactory.makeResumeViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $resumeCoordinator.path) {
            ResumeView(viewModel: resumeViewModel)
                .onChange(of: resumeViewModel.resumeViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .navigateToActivityEdit:
                        resumeCoordinator.push(next: .myExtracurricularActivityEditView)
                    case .navigateToCareerWrite:
                        resumeCoordinator.push(next: .myCareerWriteView)
                    case .navigateToActivityWrite:
                        resumeCoordinator.push(next: .myExtracurricularActivityWriteView)
                    case .navigateToCertificatedEdit:
                        resumeCoordinator.push(next: .myCertificateEdit)
                    case .navigateToCareerEdit:
                        resumeCoordinator.push(next: .myCareerEdit)
                    case .resumeViewRoutePop:
                        resumeCoordinator.pop()
                    }
                    resumeViewModel.resumeViewRoute = nil
                }
                .navigationDestination(for: ResumeRoute.self) { route in
                    switch route {
                    case .myCertificateEdit:
                        MyCertificateEditView(viewModel: resumeViewModel)
                    case .myCareerEdit:
                        MyCareerManageView(viewModel: resumeViewModel)
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
