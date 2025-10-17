//
//  MyPageCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

struct MyPageCoordinatorView: View {
    @EnvironmentObject var tabCoordinator: CertiTabCoordinator
    
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
//                .onChange(of: myPageViewModel.myPageViewRoute) { route in
//                    guard let route = route else { return }
//                    switch route {
//
//                    }
//                    myPageViewModel.myPageViewRoute = nil
//                }
//                .navigationDestination(for: MyPageRoute.self) { route in
//                    switch route {
//
//                    }
//                }
        }
        .environmentObject(myPageCoordinator)
        .onChange(of: myPageCoordinator.path) { value in
            tabCoordinator.isTabBarHidden = !value.isEmpty
        }
    }
}

#Preview {
    MyPageCoordinatorView(myPageCoordinator: MyPageCoordinator(), myPageFactory: AppDIContainer.shared.makeMyPageFactory())
}
