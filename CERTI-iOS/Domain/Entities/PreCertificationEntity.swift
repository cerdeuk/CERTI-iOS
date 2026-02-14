//
//  PreCertificationEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

struct PreCertificationEntity {
    let certifications: [PreCertificationEntityData]
    
    init(certifications: [PreCertificationEntityData]) {
        self.certifications = certifications
    }
    
    
    // MARK: - Func
    
    func toPreLicenseCardModelList() -> [PreLicenseCardModel] {
        return certifications.map { $0.toPreLicenseCardModel() }
    }
    
}

struct PreCertificationEntityData {
    let certificationID: Int
    let certificationName, certificationType, description, averagePeriod: String
    let nearestTestDate, agencyName: String
    let iconIndex: Int
    let city, state, testDate: String
    let preCertificationId: Int?
    
    init(certificationID: Int, certificationName: String, certificationType: String, description: String, averagePeriod: String, nearestTestDate: String, agencyName: String, iconIndex: Int, city: String, state: String, testDate: String, preCertificationId: Int?) {
        self.certificationID = certificationID
        self.certificationName = certificationName
        self.certificationType = certificationType
        self.description = description
        self.averagePeriod = averagePeriod
        self.nearestTestDate = nearestTestDate
        self.agencyName = agencyName
        self.iconIndex = iconIndex
        self.city = city
        self.state = state
        self.testDate = testDate
        self.preCertificationId = preCertificationId
    }
    
    
    // MARK: - Func
    
    func toPreLicenseCardModel() -> PreLicenseCardModel {
        return PreLicenseCardModel(
            imageIndex: iconIndex,
            certificationId: certificationID,
            certificationName: certificationName,
            averagePeriod: averagePeriod,
            testDate: nearestTestDate,
            agencyName: agencyName
        )
    }
    
}
