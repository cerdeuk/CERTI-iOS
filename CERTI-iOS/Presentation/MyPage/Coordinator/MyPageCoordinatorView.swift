//
//  MyPageCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

struct MyPageCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @ObservedObject var myPageCoordinator: MyPageCoordinator
    
    @StateObject private var myPageViewModel: MyPageViewModel
    
    private let myPageFactory: MyPageFactory
    
    init(myPageCoordinator: MyPageCoordinator, myPageFactory: MyPageFactory) {
        self.myPageCoordinator = myPageCoordinator
        self.myPageFactory = myPageFactory
        _myPageViewModel = StateObject(wrappedValue: myPageFactory.makeMyPageViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $myPageCoordinator.path) {
            MyPageView(viewModel: myPageViewModel)
                .onChange(of: myPageViewModel.myPageViewRoute) { route in
                    guard let route = route else { return }
                    switch route {
                    case .navigateToEditProfile:
                        myPageCoordinator.push(next: .editProfile)
                    case .navigateToManageAcademicInfo:
                        myPageCoordinator.push(next: .manageAcademicInfo)
                    case .navigateToEditUniversity:
                        myPageCoordinator.push(next: .editUniversity)
                    case .navigateToEditMajor:
                        myPageCoordinator.push(next: .editMajor)
                    case .navigateToSettings:
                        myPageCoordinator.push(next: .settings)
                    case .navigateToNotificationSettings:
                        myPageCoordinator.push(next: .notificationSettings)
                    case .navigateToManageCertificates:
                        myPageCoordinator.push(next: .manageCertificates)
                    case .navigateToEditExpectedCertificate:
                        myPageCoordinator.push(next: .editExpectedCertificate)   
                    case .navigateToEditCompletedCertificate:
                        myPageCoordinator.push(next: .editCompletedCertificate)
                    case .withDraw:
                        appCoordinator.withDraw()
                        
                    case .myPageViewRoutePop:
                        myPageCoordinator.pop()
                    }
                    myPageViewModel.myPageViewRoute = nil
                }
                .navigationDestination(for: MyPageRoute.self) { route in
                    switch route {
                    case .editProfile:
                        EditProfileView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()

                    case .manageAcademicInfo:
                        ManageAcademicInfoView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()

                    case .editUniversity:
                        MyPageUnivView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()

                    case .editMajor:
                        MyPageMajorView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()

                    case .settings:
                        SettingView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .notificationSettings:
                        NotificationSettingView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()

                    case .manageCertificates:
                        ManageCertificateView(viewModel: myPageViewModel)
                            .navigationBarBackButtonHidden()
                        
                    case .editExpectedCertificate:
                        EditCertificateView(viewModel: myPageViewModel, target: .expected)
                            .navigationBarBackButtonHidden()
                        
                    case .editCompletedCertificate:
                        EditCertificateView(viewModel: myPageViewModel, target: .completed)
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        .environmentObject(myPageCoordinator)
        .onChange(of: myPageCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}

#Preview {
    let factory: MyPageFactory = AppDIContainer.shared.makeMyPageFactory()
    @StateObject var viewModel: MyPageViewModel = factory.makeMyPageViewModel()

//    MyPageMajorView(viewModel: viewModel)
//    ManageCertificateView(viewModel: viewModel)
    ManageAcademicInfoView(viewModel: viewModel)
//    EditCertificateView(viewModel: viewModel, target: .expected)
//    NotificationSettingView(viewModel: viewModel)
}
