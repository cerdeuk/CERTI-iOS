//
//  AcquisitionDetailEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

struct AcquisitionDetailEntity {
    let acquisitionDetail: [AcquisitionDetailEntityData]
    
    init(acquisitionDetail: [AcquisitionDetailEntityData]) {
        self.acquisitionDetail = acquisitionDetail
    }
    
    // MARK: - Func
    
    func toAcquisitionDetail() -> [CertificatedDetailModel] {
        return acquisitionDetail.map { $0.toAcquisitionDetailModel() }
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
    let createdAt: String
    
    init(acquisitionId: Int, cardFrontImageUrl: String, cardBackImageUrl: String, index: Int, name: String, tags: [String], description: String, createdAt: String) {
        self.acquisitionId = acquisitionId
        self.cardFrontImageUrl = cardFrontImageUrl
        self.cardBackImageUrl = cardBackImageUrl
        self.index = index
        self.name = name
        self.tags = tags
        self.description = description
        self.createdAt = createdAt
    }
    
    // MARK: - Func
    
    func toAcquisitionDetailModel() -> CertificatedDetailModel {
        return CertificatedDetailModel(
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            cardBackImageUrl: cardBackImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            createdAt: createdAt
        )
    }
}
