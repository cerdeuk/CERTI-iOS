//
//  MyPageViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

import os

enum MyPageViewRoute {
    case navigateToEditProfile
    case navigateToManageAcademicInfo
    case navigateToEditUniversity
    case navigateToEditMajor
    case navigateToManageCertificates
    case navigateToSettings
    case navigateToNotificationSettings
    
    case myPageViewRoutePop
}

@MainActor
final class MyPageViewModel: ObservableObject {
    @Published var myPageViewRoute: MyPageViewRoute?

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "MyPage")

}


// MARK: - Navigation Func

extension MyPageViewModel {
    
    func navigateToEditProfile() {
        myPageViewRoute = .navigateToEditProfile
    }
    
    func navigateToManageAcademicInfo() {
        myPageViewRoute = .navigateToManageAcademicInfo
    }
    
    func navigateToEditUniversity() {
        myPageViewRoute = .navigateToEditUniversity
    }

    func navigateToEditMajor() {
        myPageViewRoute = .navigateToEditMajor
    }
    
    func navigateToManageCertificates() {
        myPageViewRoute = .navigateToManageCertificates
    }
    
    func navigateToSettings() {
        myPageViewRoute = .navigateToSettings
    }
    
    func navigateToNotificationSettings() {
        myPageViewRoute = .navigateToNotificationSettings
    }
    
    func myPageViewRoutePop() {
        myPageViewRoute = .myPageViewRoutePop
    }
}
