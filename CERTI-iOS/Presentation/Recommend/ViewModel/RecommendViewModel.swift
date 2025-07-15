//
//  RecommendViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

class RecommendViewModel: ObservableObject {
    
    var username: String = AuthManager.shared.nickname
    
    @Published var licenseCards: [LicenseCardModel] = LicenseCardModel.dummy()
    @Published var isFilterModalPresented = false
    @Published var selectedCategories: [JobCategory] = [
            .marketing, .sales, .rnd
        ]
    var interestTags: [String] {
        selectedCategories.map(\.description)
    }
    
    func toggleFavorite(id: Int) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
}
