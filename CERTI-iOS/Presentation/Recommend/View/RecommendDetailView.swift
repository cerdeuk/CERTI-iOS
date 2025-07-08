//
//  RecommendDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendDetailView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator

    var body: some View {
        VStack {
            Button("이력서 탭으로 전환") {
                tabRouter.switchTab(tab: .resume)
            }
        }
    }
}
