//
//  CertiTabBarCoordinatorView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CertiTabBarCoordinatorView: View {
    @ObservedObject var tabCoordinator: CertiTabCoordinator
    
    private let appDIContainer: AppDIContainer
  
    init(tabCoordinator: CertiTabCoordinator, appDIContainer: AppDIContainer) {
        self.tabCoordinator = tabCoordinator
        self.appDIContainer = appDIContainer
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch tabCoordinator.selectedTab {
                case .home:
                    HomeCoordinatorView(homeCoordinator: tabCoordinator.homeCoordinator, homeFactory: appDIContainer.makeHomeFactory())
                case .category:
                    CategoryCoordinatorView(categoryCoordinator: tabCoordinator.categoryCoordinator, categoryFactory: appDIContainer.makeCategoryFactory())
                case .recommend:
                    RecommendCoordinatorView(recommendCoordinator: tabCoordinator.recommendCoordinator, recommendFactory: appDIContainer.makeRecommendFactory())
                case .resume:
                    ResumeCoordinatorView(resumeCoordinator: tabCoordinator.resumeCoordinator, resumeFactory: appDIContainer.makeResumeFactory())
                }
            }
            .id(tabCoordinator.selectedTab)
            .environmentObject(tabCoordinator)

            if !tabCoordinator.isTabBarHidden {
                CertiTabBarView(selectedTab: $tabCoordinator.selectedTab)
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
