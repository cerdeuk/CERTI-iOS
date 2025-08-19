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
    let id: Int
    let name: String
    let averagePeriod: String
    let nearestTestDate: String
    let agencyName: String
    let iconIndex: Int
    
    init(id: Int, name: String, averagePeriod: String, nearestTestDate: String, agencyName: String, iconIndex: Int) {
        self.id = id
        self.name = name
        self.averagePeriod = averagePeriod
        self.nearestTestDate = nearestTestDate
        self.agencyName = agencyName
        self.iconIndex = iconIndex
    }
    
    
    // MARK: - Func
    
    func toPreLicenseCardModel() -> PreLicenseCardModel {
        return PreLicenseCardModel(
            imageIndex: iconIndex,
            certificationId: id,
            certificationName: name,
            averagePeriod: averagePeriod,
            testDate: nearestTestDate,
            agencyName: agencyName
        )
    }
    
}
