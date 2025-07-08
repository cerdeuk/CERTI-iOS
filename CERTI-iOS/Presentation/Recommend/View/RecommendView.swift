//
//  RecommendView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct RecommendView: View {
    @EnvironmentObject var recommendCoordinator: RecommendCoordinator

    var body: some View {
        VStack {
            Text("추천 화면")
            Button("디테일 보기") {
                recommendCoordinator.push(next: .detail)
            }
        }
    }
}
