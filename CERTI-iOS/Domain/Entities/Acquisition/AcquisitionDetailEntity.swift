//
//  AcquisitionDetailEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

struct AcquisitionDetailEntity {
    let acquisitionDetail: AcquisitionDetailEntityData
    
    init(acquisitionDetail: AcquisitionDetailEntityData) {
        self.acquisitionDetail = acquisitionDetail
    }
}

struct AcquisitionDetailEntityData {
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let cardBackImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let acquisitionDate: String
    
    init(acquisitionId: Int, cardFrontImageUrl: String, cardBackImageUrl: String, index: Int, name: String, tags: [String], description: String, acquisitionDate: String) {
        self.acquisitionId = acquisitionId
        self.cardFrontImageUrl = cardFrontImageUrl
        self.cardBackImageUrl = cardBackImageUrl
        self.index = index
        self.name = name
        self.tags = tags
        self.description = description
        self.acquisitionDate = acquisitionDate
    }
    
    // MARK: - Func
    
    func toCertificatedDetailModel() -> CertificatedDetailModel {
        return CertificatedDetailModel(
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            cardBackImageUrl: cardBackImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            acquisitionDate: acquisitionDate
        )
    }
}
