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
                    case .navigateToActivityManage:
                        resumeCoordinator.push(next: .myActivityManageView)
                    case .navigateToCareerWrite(let mode):
                        resumeCoordinator.push(next: .myCareerWriteView(mode: mode))
                    case .navigateToActivityWrite:
                        resumeCoordinator.push(next: .myActivityWriteView)
                    case .navigateToCertificatedEdit:
                        resumeCoordinator.push(next: .myCertificateEdit)
                    case .navigateToCareerManage:
                        resumeCoordinator.push(next: .myCareerManageView)
                    case .resumeViewRoutePop:
                        resumeCoordinator.pop()
                    }
                    resumeViewModel.resumeViewRoute = nil
                }
                .navigationDestination(for: ResumeRoute.self) { route in
                    switch route {
                    case .myCertificateEdit:
                        MyCertificateEditView(viewModel: resumeViewModel)
                    case .myCareerManageView:
                        MyCareerManageView(viewModel: resumeViewModel)
                    case .myCareerWriteView(let mode):
                        MyCareerWriteView(viewModel: resumeViewModel, mode: mode)
                    case .myActivityManageView:
                        MyActivityManageView(viewModel: resumeViewModel)
                    case .myActivityWriteView:
                        MyActivityWriteView(viewModel: resumeViewModel)
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
