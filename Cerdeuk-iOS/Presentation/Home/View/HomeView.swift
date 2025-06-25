//
//  HomeView.swift
//  Cerdeuk-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: HomeCoordinator

    var body: some View {
        VStack {
            Text("홈 화면")
            Button("디테일 보기") {
                coordinator.push(next: .detail)
            }
        }
    }
}
