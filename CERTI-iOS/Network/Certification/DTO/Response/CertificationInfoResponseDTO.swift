//
//  CertificationInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

struct CertificationInfoResponseDTO: Decodable {
    let certificationId: Int
    let certificationName: String
    let averagePeriod: String
    let nearestTestDate: String
    let agencyName: String
    let iconIndex: Int
}

extension CertificationInfoResponseDTO {
    func toPreLicenseCardModel() -> PreLicenseCardModel {
        return PreLicenseCardModel(
            imageIndex: iconIndex,
            certificationId: certificationId,
            certificationName: certificationName,
            averagePeriod: averagePeriod,
            testDate: nearestTestDate,
            agencyName: agencyName
        )
    }
}
