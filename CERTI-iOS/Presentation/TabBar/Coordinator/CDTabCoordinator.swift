//
//  CDTabCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum CDTabRoute: Int, CaseIterable, Hashable {
    case home, category, recommend, resume

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .category:
            return "카테고리"
        case .recommend:
            return "추천"
        case .resume:
            return "이력서"
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return .iconHome
        case .category:
            return .iconCategory
        case .recommend:
            return .iconRecommendation
        case .resume:
            return .iconResume
        }
    }
}


class CDTabCoordinator: ObservableObject {
    
    //MARK: - Property Wrappers
    
    @Published var selectedTab: CDTabRoute = .home
    @Published var isTabBarHidden: Bool = false
    
    let homeCoordinator = HomeCoordinator()
    let listCoordinator = HomeCoordinator()
    let suggestCoordinator = SuggestCoordinator()
    let resumeCoordinator = SuggestCoordinator()

    //MARK: - Method
    
    func switchTab(tab: CDTabRoute) {
        isTabBarHidden = false
        selectedTab = tab
    }
}
