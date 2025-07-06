//
//  SuggestDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct SuggestDetailView: View {
    @EnvironmentObject var tabRouter: CDTabCoordinator

    var body: some View {
        VStack {
            Button("홈 탭으로 전환") {
                tabRouter.switchTab(tab: .home)
            }
        }
    }
}
