//
//  CertificateDetailModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/12/25.
//

import SwiftUI

struct CertificateDetailModel: Identifiable, Decodable {
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
    
    var id: Int { certificationId }
}
