//
//  RecommendLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/9/25.
//

import SwiftUI

struct RecommendLicenseCardModel: Identifiable {
    let id: Int

    var licenseName: String
    var recommendScore: Int
    var tagChip: [String]
}

extension RecommendLicenseCardModel {
    static func dummy() -> [RecommendLicenseCardModel] {
        return [
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 2, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 3, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 4, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 5, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 6, licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"])
        ]
    }
}
