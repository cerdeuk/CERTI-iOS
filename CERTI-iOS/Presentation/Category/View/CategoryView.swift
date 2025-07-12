//
//  CategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            CategoryTabBar(
                        selectedCategory: $viewModel.selectedCategory,
                        onSearchTapped: {
                            categoryCoordinator.push(next: .detail)
                        }
                    )
            
            FavoriteFilterToggleButton(isSelected: viewModel.isFilterToggle) {
                viewModel.isFilterToggle.toggle()
                print("즐겨찾기 버튼 눌림")
            }
            
            CategoryLicenseCardList(viewModel: viewModel)
        }
    }
}
