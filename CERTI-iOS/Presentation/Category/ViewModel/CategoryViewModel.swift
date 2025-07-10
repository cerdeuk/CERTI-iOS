//
//  CategoryViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//


import SwiftUI

class CategoryViewModel: ObservableObject {
    
    @Published var licenseCards: [LicenseCardModel] = LicenseCardModel.dummy()
    @Published var isFilterToggle = false
    @Published var selectedCategory: JobCategory = .business
    @Published var inputText: String = ""
    @Published var searchResult: SearchResultType? = nil
    
    func toggleFavorite(id: UUID) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
    
    var trimmedInput: String {
        inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
