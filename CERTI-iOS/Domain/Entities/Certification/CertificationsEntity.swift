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
}

struct CertificationsEntityData {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let tags: [String]
    let testType: String
    let isFavorite: Bool
    
    init(certificationId: Int, certificationName: String, certificationType: String, tags: [String], testType: String, isFavorite: Bool) {
        self.certificationId = certificationId
        self.certificationName = certificationName
        self.certificationType = certificationType
        self.tags = tags
        self.testType = testType
        self.isFavorite = isFavorite
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
}
