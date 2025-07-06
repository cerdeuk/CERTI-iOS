//
//  HomeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeDetailView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator

    var body: some View {
        VStack {
            Button("카테고리 탭으로 전환") {
                tabRouter.switchTab(tab: .category)
            }
        }
    }
}
