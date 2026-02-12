//
//  MyPageCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

enum MyPageRoute: Hashable {
    case editProfile
    case manageAcademicInfo
    case editUniversity
    case editMajor
    case manageCertificates
    case settings
    case notificationSettings
    case editExpectedCertificate
    case editCompletedCertificate
    case certificateDetail
}

final class MyPageCoordinator: ObservableObject {
    
    //MARK: - Property Wrappers
    
    @Published var path = NavigationPath()
    
    //MARK: - Method
    
    //다음에 보여질 view를 navigationStack에 push
    func push(next route: MyPageRoute) {
        path.append(route)
    }
    
    //현재 view를 navigationStack에서 pop
    func pop() {
        path.removeLast()
    }
    
    //맨 처음으로 돌아감(navigationStack 초기화)
    func reset() {
        path = NavigationPath()
    }
}
