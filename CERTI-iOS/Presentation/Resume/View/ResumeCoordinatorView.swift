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
    @StateObject var myPageViewModel: MyPageViewModel
    
    private let resumeFactory: ResumeFactory
    private let myPageFactory: MyPageFactory

    
    init(resumeCoordinator: ResumeCoordinator, resumeFactory: ResumeFactory, myPageFactory: MyPageFactory) {
        self.resumeCoordinator = resumeCoordinator
        self.resumeFactory = resumeFactory
        _resumeViewModel = StateObject(wrappedValue: resumeFactory.makeResumeViewModel())
        self.myPageFactory = myPageFactory
        _myPageViewModel = StateObject(wrappedValue: myPageFactory.makeMyPageViewModel())
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
                    case .navigateToActivityWrite(let mode):
                        resumeCoordinator.push(next: .myActivityWriteView(mode: mode))
                    case .navigateToCertificatedEdit:
                        resumeCoordinator.push(next: .myCertificateEdit)
                    case .navigateToCareerManage:
                        resumeCoordinator.push(next: .myCareerManageView)
                    case .resumeViewRoutePop:
                        resumeCoordinator.pop()
                    case .navigateToEditProfile:
                        resumeCoordinator.push(next: .editProfile)
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
                    case .myActivityWriteView(let mode):
                        MyActivityWriteView(viewModel: resumeViewModel, mode: mode)
                    case .editProfile:
                        EditProfileView(viewModel: myPageViewModel) {
                            resumeCoordinator.pop()
                        }
                        .navigationBarBackButtonHidden()
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
