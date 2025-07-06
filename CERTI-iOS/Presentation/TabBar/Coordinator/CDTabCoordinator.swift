//
//  CDTabCoordinator.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

enum CDTabRoute: Int, CaseIterable, Hashable {
    case home, list, suggest, resume

    var title: String {
        switch self {
        case .home:
            return "홈"
        case .list:
            return "목록"
        case .suggest:
            return "추천"
        case .resume:
            return "이력서"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house"
        case .list:
            return "list.bullet"
        case .suggest:
            return "sparkles"
        case .resume:
            return "doc.text"
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
