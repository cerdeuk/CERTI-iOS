//
//  RecommendViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

class RecommendViewModel: ObservableObject {
    
    @Published var licenseCards: [LicenseCardModel] = LicenseCardModel.dummy()
}
