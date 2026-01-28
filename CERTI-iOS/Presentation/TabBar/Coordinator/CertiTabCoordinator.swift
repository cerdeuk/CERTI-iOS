//
//  CertiTabCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum CertiTabRoute: Int, CaseIterable, Hashable {
    case home, certificate, resume, mypage

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .certificate:
            return "자격증"
        case .resume:
            return "이력서"
        case .mypage:
            return "마이페이지"
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return .iconHome
        case .certificate:
            return .iconCategory    //TODO: - 파일명 변경
        case .resume:
            return .iconResume
        case .mypage:
            return .iconPerson24
        }
    }
}


class CertiTabCoordinator: ObservableObject {
    
    //MARK: - Property Wrappers
    
    @Published var selectedTab: CertiTabRoute = .certificate
    @Published var isTabBarHidden: Bool = false
    
    let homeCoordinator = HomeCoordinator()
    let certificateCoordinator = CertificateCoordinator()
    let resumeCoordinator = ResumeCoordinator()
    let mypageCoordinator = MyPageCoordinator()

    //MARK: - Method
    
    func switchTab(tab: CertiTabRoute) {
        isTabBarHidden = false
        selectedTab = tab
    }
}
