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
    let certificationId: Int
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let acquisitionDate: String
    let grade: String?
    let certificationType: String
    
    init(certificationId: Int, acquisitionId: Int, cardFrontImageUrl: String, index: Int, name: String, tags: [String], description: String, acquisitionDate: String, grade: String?, certificationType: String) {
        self.certificationId = certificationId
        self.acquisitionId = acquisitionId
        self.cardFrontImageUrl = cardFrontImageUrl
        self.index = index
        self.name = name
        self.tags = tags
        self.description = description
        self.acquisitionDate = acquisitionDate
        self.grade = grade
        self.certificationType = certificationType
    }
    
    
    // MARK: - Func
    
    func toCertificatedModel() -> CertificatedModel {
        return CertificatedModel(
            certificationId: certificationId,
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            acquisitionDate: acquisitionDate,
            grade: grade,
            certificationType: certificationType
        )
    }
}
