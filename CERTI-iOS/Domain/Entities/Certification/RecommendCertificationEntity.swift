//
//  RecommendCertificationEntity.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

struct RecommendCertificationEntity {
    let id: Int
    let licenseName: String
    let recommendScore: Int
    let tagChip: [String]
    
    init(id: Int, licenseName: String, recommendScore: Int, tagChip: [String]) {
        self.id = id
        self.licenseName = licenseName
        self.recommendScore = recommendScore
        self.tagChip = tagChip
    }
    
    
    // MARK: - Func
    
    func toRecommendLicenseCardModel() -> RecommendLicenseCardModel {
        return RecommendLicenseCardModel(
            id: id,
            licenseName: licenseName,
            tagChip: tagChip
        )
    }
}
