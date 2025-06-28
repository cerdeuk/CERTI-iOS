//
//  CDTabBarCoordinatorView.swift
//  Cerdeuk-iOS
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
                case .list:
                    HomeCoordinatorView(homeCoordinator: tabCoordinator.homeCoordinator)
                case .suggest:
                    SuggestCoordinatorView(suggestCoordinator: tabCoordinator.suggestCoordinator)
                case .resume:
                    HomeCoordinatorView(homeCoordinator: tabCoordinator.homeCoordinator)
                }
            }
            .id(tabCoordinator.selectedTab)

            CDTabBarView(selectedTab: $tabCoordinator.selectedTab)
        }
        .onChange(of: tabCoordinator.selectedTab) { newTab in
            switch newTab {
            case .home:
                tabCoordinator.homeCoordinator.reset()
            case .list:
                tabCoordinator.listCoordinator.reset()
            case .suggest:
                tabCoordinator.suggestCoordinator.reset()
            case .resume:
                tabCoordinator.resumeCoordinator.reset()
            }
        }
    }
}
