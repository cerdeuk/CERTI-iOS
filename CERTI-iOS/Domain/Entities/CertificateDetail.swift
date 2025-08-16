//
//  CertificateDetail.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

struct CertificateDetail: Equatable, Identifiable {
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
    
    var id: Int { certificationId }
}

extension CertificateDetail {
    func toPresentation() -> CertificateDetailModel {
        CertificateDetailModel(
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
            expirationPeriod: expirationPeriod
        )
    }
}
