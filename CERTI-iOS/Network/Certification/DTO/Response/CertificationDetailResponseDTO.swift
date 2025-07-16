//
//  CertificationDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import Foundation

typealias CertificationDetailResponseDTO = BaseResponseDTO<SearchCertificationData>

struct CertificationDetailData: Decodable {
    let certificationId: Int
    let certificationName: String
    let tags: [String]
    let averagePeriod: String
    let charge: Int
    let agencyName: String
    let testType: String
    let description: String
    let testDateInformation: String
    let applicationMethod: String
    let applicationUrl: String
    let expirationPeriod: String
}
