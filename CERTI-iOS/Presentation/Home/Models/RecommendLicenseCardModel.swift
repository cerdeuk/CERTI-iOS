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
    var ranking: Int
}

extension RecommendLicenseCardModel {
    static func dummy() -> [RecommendLicenseCardModel] {
        return [
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 1),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 2),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 3),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 4),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 5),
            RecommendLicenseCardModel(licenseName: "OPIc", recommendScore: 90, tagChip: ["컴퓨터공학", "재무/세무/IR", "재무/세무/IR"], ranking: 6)
        ]
    }
}
