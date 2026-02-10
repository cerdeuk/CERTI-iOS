//
//  CertificationEntity.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/23/25.
//

import Foundation

struct CertificationsEntity {
    let certifications: [CertificationsEntityData]
    
    init(certifications: [CertificationsEntityData]) {
        self.certifications = certifications
    }
    
    
    // MARK: - Func
    
    func toLicenseCardModelList() -> [LicenseCardModel] {
        return certifications.map { $0.toLicenseCardModel() }
    }
    
    func toRecommendLicenseCardModelList() -> [RecommendLicenseCardModel] {
        return certifications.map { $0.toRecommendLicenseCardModel() }
    }
}

struct CertificationsEntityData {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let tags: [String]
    let testType: String
    let isFavorite: Bool
    let recommendScore: Int?
    let description: String?
    
    init(
        certificationId: Int,
        certificationName: String,
        certificationType: String,
        tags: [String],
        testType: String,
        isFavorite: Bool,
        recommendScore: Int?,
        desceiption: String?
    ) {
        self.certificationId = certificationId
        self.certificationName = certificationName
        self.certificationType = certificationType
        self.tags = tags
        self.testType = testType
        self.isFavorite = isFavorite
        self.recommendScore = recommendScore
        self.description = desceiption
    }
    
    
    // MARK: - Func
    
    func toLicenseCardModel() -> LicenseCardModel {
        return LicenseCardModel(
            certificationId: certificationId,
            certificationName: certificationName,
            certificationType: certificationType,
            tags: tags,
            testType: testType,
            isFavorite: isFavorite
        )
    }
    
    func toRecommendLicenseCardModel() -> RecommendLicenseCardModel {
        return RecommendLicenseCardModel(
            id: certificationId,
            licenseName: certificationName,
            recommendScore: recommendScore ?? 0,
            tagChip: tags
        )
    }
}
