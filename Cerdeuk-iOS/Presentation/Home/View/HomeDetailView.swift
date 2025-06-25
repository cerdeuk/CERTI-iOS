//
//  HomeDetailView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeDetailView: View {
    let navigateToSuggestTab: () -> Void

    var body: some View {
        VStack {
            Text("홈 디테일 화면")
            Button {
                navigateToSuggestTab
            } label: {
                Text("추천화면으로 넘어가기")
            }

        }
    }
}
