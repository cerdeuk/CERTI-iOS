//
//  CategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator

    var body: some View {
        VStack {
            Text("카테고리 화면")
            Button("디테일 보기") {
                categoryCoordinator.push(next: .detail)
            }
        }
    }
}

#Preview {
    CategoryView()
}
