//
//  PreCertificationInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

typealias PreCertificationInfoResponseDTO = BaseResponseDTO<PreCertificationData>

struct PreCertificationData: Decodable {
    let data: [PreCertificationDataInfo]
}

extension PreCertificationData {
    func toPreCertificationEntity() -> PreCertificationEntity {
        return PreCertificationEntity(
            certifications: data.map { $0.toPreCertificationEntityData() }
        )
    }
}

struct PreCertificationDataInfo: Codable {
    let certificationID: Int
    let certificationName, certificationType, description, averagePeriod: String
    let nearestTestDate, agencyName: String
    let iconIndex: Int
    let city, state, testDate: String

    enum CodingKeys: String, CodingKey {
        case certificationID = "certificationId"
        case certificationName, certificationType, description, averagePeriod, nearestTestDate, agencyName, iconIndex, city, state, testDate
    }
    
    func toPreCertificationEntityData() -> PreCertificationEntityData {
        return PreCertificationEntityData(
            certificationID: certificationID,
            certificationName: certificationName,
            certificationType: certificationType,
            description: description,
            averagePeriod: averagePeriod,
            nearestTestDate: nearestTestDate,
            agencyName: agencyName,
            iconIndex: iconIndex,
            city: city,
            state: state,
            testDate: testDate
        )
    }
}
