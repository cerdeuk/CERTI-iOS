//
//  HomeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeDetailView: View {
    @EnvironmentObject var tabRouter: CDTabCoordinator

    var body: some View {
        VStack {
            Button("추천 탭으로 전환") {
                tabRouter.switchTab(tab: .recommend)
            }
        }
    }
}
