//
//  CDTabBarCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CDTabBarCoordinatorView: View {
    @ObservedObject var tabCoordinator: CDTabCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch tabCoordinator.selectedTab {
                case .home:
                    HomeCoordinatorView(homeCoordinator: tabCoordinator.homeCoordinator)
                case .category:
                    CategoryCoordinatorView(categoryCoordinator: tabCoordinator.categoryCoordinator)
                case .recommend:
                    RecommendCoordinatorView(recommendCoordinator: tabCoordinator.recommendCoordinator)
                case .resume:
                    ResumeCoordinatorView(resumeCoordinator: tabCoordinator.resumeCoordinator)
                }
            }
            .id(tabCoordinator.selectedTab)
            .environmentObject(tabCoordinator)

            if !tabCoordinator.isTabBarHidden {
                CDTabBarView(selectedTab: $tabCoordinator.selectedTab)
            }
        }
        .onChange(of: tabCoordinator.selectedTab) { newTab in
            switch newTab {
            case .home:
                tabCoordinator.homeCoordinator.reset()
            case .category:
                tabCoordinator.categoryCoordinator.reset()
            case .recommend:
                tabCoordinator.recommendCoordinator.reset()
            case .resume:
                tabCoordinator.resumeCoordinator.reset()
            }
        }
    }
}
