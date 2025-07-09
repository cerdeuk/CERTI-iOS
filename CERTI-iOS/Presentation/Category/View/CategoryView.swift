//
//  CategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    @StateObject private var viewModel = CategoryViewModel()
    @State private var isFilterToggle = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            CategoryTabBarView{
                categoryCoordinator.push(next: .detail)
            }
            FavoriteFilterToggleButton(isSelected: isFilterToggle) {
                isFilterToggle.toggle()
                print("즐겨찾기 버튼 눌림")
            }
            LicenseCardList(viewModel: viewModel)
        }
    }
}

//#Preview {
//    CategoryView()
//}
