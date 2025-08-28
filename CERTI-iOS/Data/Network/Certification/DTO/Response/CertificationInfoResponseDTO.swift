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
    func toPreCertificationEntityData() -> PreCertificationEntityData {
        return PreCertificationEntityData(
            id: certificationId,
            name: certificationName,
            averagePeriod: averagePeriod,
            nearestTestDate: nearestTestDate,
            agencyName: agencyName,
            iconIndex: iconIndex
        )
    }
}
