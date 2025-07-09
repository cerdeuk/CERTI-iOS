//
//  CategoryViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//


import SwiftUI

class CategoryViewModel: ObservableObject {
    
    @Published var licenseCards: [LicenseCardModel] = LicenseCardModel.dummy()
    
    func toggleFavorite(id: UUID) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
}
