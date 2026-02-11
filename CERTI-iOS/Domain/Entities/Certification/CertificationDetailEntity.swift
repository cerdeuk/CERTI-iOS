//
//  CertificationDetailEntity.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

struct CertificationDetailEntity {
    let certificationId: Int
    let certificationName: String
    let tags: [String]
    let averagePeriod: String
    let charge: String
    let agencyName: String
    let testType: String
    let description: String
    let testDateInformation: String
    let applicationMethod: String
    let applicationUrl: String
    let expirationPeriod: String
    let certState: String
    
    init(certificationId: Int, certificationName: String, tags: [String], averagePeriod: String, charge: String, agencyName: String, testType: String, description: String, testDateInformation: String, applicationMethod: String, applicationUrl: String, expirationPeriod: String, certState: String) {
        self.certificationId = certificationId
        self.certificationName = certificationName
        self.tags = tags
        self.averagePeriod = averagePeriod
        self.charge = charge
        self.agencyName = agencyName
        self.testType = testType
        self.description = description
        self.testDateInformation = testDateInformation
        self.applicationMethod = applicationMethod
        self.applicationUrl = applicationUrl
        self.expirationPeriod = expirationPeriod
        self.certState = certState
    }
    
    
    // MARK: - Func
    
    func toCertificationDetailModel() -> CertificateDetailModel {
        return CertificateDetailModel(
            certificationId: certificationId,
            certificationName: certificationName,
            tags: tags,
            averagePeriod: averagePeriod,
            charge: charge,
            agencyName: agencyName,
            testType: testType,
            description: description,
            testDateInformation: testDateInformation,
            applicationMethod: applicationMethod,
            applicationUrl: applicationUrl,
            expirationPeriod: expirationPeriod,
            certState: certState
        )
    }
}
