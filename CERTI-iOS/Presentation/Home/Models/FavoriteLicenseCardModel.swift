//
//  FavoriteLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import SwiftUI

struct FavoriteLicenseCardModel: Identifiable {
    var id: UUID = UUID()
    
    let certificationId: Int
    let certificationName: String
    let testType: String
    let agencyName: String
    let certificationType: String
    var isFavorite: Bool
}
