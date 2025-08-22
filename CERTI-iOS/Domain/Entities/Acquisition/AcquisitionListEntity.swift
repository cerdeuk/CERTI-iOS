//
//  AcquisitionListEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

struct AcquisitionListEntity {
    let acquisitionList: [AcquisitionListEntityData]
    
    init(acquisitionList: [AcquisitionListEntityData]) {
        self.acquisitionList = acquisitionList
    }
    
    
    // MARK: - Func

    func toAcquisitionList() -> [CertificatedListModel] {
        return acquisitionList.map { $0.toAcquisitionListModel() }
    }
}

struct AcquisitionListEntityData {
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let createdAt: String
    
    init(acquisitionId: Int, cardFrontImageUrl: String, index: Int, name: String, tags: [String], description: String, createdAt: String) {
        self.acquisitionId = acquisitionId
        self.cardFrontImageUrl = cardFrontImageUrl
        self.index = index
        self.name = name
        self.tags = tags
        self.description = description
        self.createdAt = createdAt
    }
    
    
    // MARK: - Func
    
    func toAcquisitionListModel() -> CertificatedListModel {
        return CertificatedListModel(
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            createdAt: createdAt
        )
    }
}
