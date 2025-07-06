//
//  ResumeDetailView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/6/25.
//

import SwiftUI

struct ResumeDetailView: View {
    @EnvironmentObject var tabRouter: CertiTabCoordinator

    var body: some View {
        VStack {
            Button("홈 탭으로 전환") {
                tabRouter.switchTab(tab: .home)
            }
        }
    }
}
