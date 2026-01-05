//
//  CategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: CategoryViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            CategoryTabBar(
                        selectedCategory: $viewModel.selectedCategory,
                        onSearchTapped: {
                            viewModel.navigateToSearch()
                        }
                    )
            
            FavoriteFilterToggleButton(isSelected: viewModel.isFilterToggle) {
                viewModel.isFilterToggle.toggle()
                Task {
                    await viewModel.getCategoryList()
                }
            }
            
            CategoryLicenseCardList(viewModel: viewModel)
                .padding(.horizontal, 20)
        }
        .task(id: viewModel.selectedCategory) {
            await viewModel.getCategoryList()
        }
    }
}
