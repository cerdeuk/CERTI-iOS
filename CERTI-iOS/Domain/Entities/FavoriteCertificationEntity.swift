//
//  FavoriteCertificationEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

struct FavoriteCertificationEntity {
    let certifications: [FavoriteCertificationEntityData]
    
    init(certifications: [FavoriteCertificationEntityData]) {
        self.certifications = certifications
    }
    
    
    // MARK: - Func
    
    func toFavoriteLicenseCardModelList() -> [FavoriteLicenseCardModel] {
        return certifications.map { $0.toFavoriteLicenseCardModel() }
    }
    
}

struct FavoriteCertificationEntityData {
    let certificationId: Int
    let certificationName: String
    let testType: String
    let agencyName: String
    let certificationType: String
    let isFavorite: Bool
    
    init(certificationId: Int, certificationName: String, testType: String, agencyName: String, certificationType: String, isFavorite: Bool) {
        self.certificationId = certificationId
        self.certificationName = certificationName
        self.testType = testType
        self.agencyName = agencyName
        self.certificationType = certificationType
        self.isFavorite = isFavorite
    }
    
    // MARK: - Func
    
    func toFavoriteLicenseCardModel() -> FavoriteLicenseCardModel {
        return FavoriteLicenseCardModel(
            certificationId: certificationId,
            certificationName: certificationName,
            testType: testType,
            agencyName: agencyName,
            certificationType: certificationType,
            isFavorite: isFavorite
        )
    }
}
