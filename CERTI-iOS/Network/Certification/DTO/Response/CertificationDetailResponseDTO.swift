//
//  CertificationDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import Foundation

typealias CertificationDetailResponseDTO = BaseResponseDTO<CertificationDetailData>

struct CertificationDetailData: Decodable {
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
}

extension CertificationDetailData {
    func toDomain() -> CertificateDetailModel {
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
            expirationPeriod: expirationPeriod
        )
    }
}
