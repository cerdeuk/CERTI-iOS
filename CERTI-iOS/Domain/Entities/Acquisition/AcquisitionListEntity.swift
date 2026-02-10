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

    func toCertificatedModel() -> [CertificatedModel] {
        return acquisitionList.map { $0.toCertificatedModel() }
    }
}

struct AcquisitionListEntityData {
    let acquisitionID: Int
    let cardFrontImageURL, certificationType: String
    let index: Int
    let name: String
    let tags: [String]
    let description, acquisitionDate, grade: String

    enum CodingKeys: String, CodingKey {
        case acquisitionID = "acquisitionId"
        case cardFrontImageURL = "cardFrontImageUrl"
        case certificationType, index, name, tags, description, acquisitionDate, grade
    }
    
    init(acquisitionID: Int, cardFrontImageURL: String, certificationType: String, index: Int, name: String, tags: [String], description: String, acquisitionDate: String, grade: String) {
        self.acquisitionID = acquisitionID
        self.cardFrontImageURL = cardFrontImageURL
        self.certificationType = certificationType
        self.index = index
        self.name = name
        self.tags = tags
        self.description = description
        self.acquisitionDate = acquisitionDate
        self.grade = grade
    }
    
    
    // MARK: - Func
    
    func toCertificatedModel() -> CertificatedModel {
        return CertificatedModel(
            acquisitionId: acquisitionID,
            cardFrontImageUrl: cardFrontImageURL,
            index: index,
            name: name,
            tags: tags,
            description: description,
            createdAt: acquisitionDate
        )
    }
}
