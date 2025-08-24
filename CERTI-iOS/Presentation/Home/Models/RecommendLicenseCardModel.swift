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
    var tagChip: [String]
}

extension RecommendLicenseCardModel {
    static func dummy() -> [RecommendLicenseCardModel] {
        return [
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"]),
            RecommendLicenseCardModel(id: 1, licenseName: "OPIc", tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"])
        ]
    }
}
