//
//  CertificateDetailModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

struct CertificateDetailModel: Equatable, Identifiable {
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
