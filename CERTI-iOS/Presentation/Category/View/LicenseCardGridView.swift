//
//  LicenseCardGridView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct LicenseCardGridView: View {
    
    @StateObject var viewModel = LicenseCardViewModel()
    let showOnlyFavorites: Bool
    
    let columns = [
        GridItem(.fixed(335))
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.filteredCards(onlyFavorites: showOnlyFavorites)) { item in
                        LicenseCardGridItemView(model: item) {
                            viewModel.toggleFavorite(id: item.id)
                        }
                    }
                }
            }
        }
    }
}
