//
//  RecommendLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/9/25.
//

import SwiftUI

struct RecommendLicenseCardModel: Identifiable {
    var id: UUID = UUID()
    
    var licenseName: String
    var recommendScore: Int
    var tagChip: [String]
}

extension RecommendLicenseCardModel {
    static func dummy() -> [RecommendLicenseCardModel] {
        return [
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"])
        ]
    }
}
