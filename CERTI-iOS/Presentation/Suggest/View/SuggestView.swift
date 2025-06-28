//
//  SuggestView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct SuggestView: View {
    @EnvironmentObject var coordinator: SuggestCoordinator

    var body: some View {
        VStack {
            Text("추천 화면")
            Button("디테일 보기") {
                coordinator.push(next: .detail)
            }
        }
    }
}
