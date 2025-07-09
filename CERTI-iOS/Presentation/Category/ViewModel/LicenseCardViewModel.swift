//
//  LicenseCardViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//


import SwiftUI

class LicenseCardViewModel: ObservableObject {
    @Published var licenseCards: [LicenseCardModel] = LicenseCardModel.dummy()
    
    func toggleFavorite(id: UUID) {
        guard let index = licenseCards.firstIndex(where: { $0.id == id }) else { return }
        licenseCards[index].isFavorite.toggle()
    }
    
    func filteredCards(onlyFavorites: Bool) -> [LicenseCardModel] {
        onlyFavorites ? licenseCards.filter { $0.isFavorite } : licenseCards
    }
}
