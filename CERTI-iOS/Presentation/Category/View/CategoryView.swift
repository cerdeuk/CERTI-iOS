//
//  CategoryView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var categoryCoordinator: CategoryCoordinator
    @StateObject private var viewModel = LicenseCardViewModel()
    @State private var showOnlyFavorite = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            CategoryTabBarView{
                categoryCoordinator.push(next: .detail)
            }
            FavoriteFilterToggleButton(isSelected: showOnlyFavorite) {
                showOnlyFavorite.toggle()
            }
            LicenseCardGridView(viewModel: viewModel, showOnlyFavorites: showOnlyFavorite)
        }
    }
}

#Preview {
    CategoryView()
}
