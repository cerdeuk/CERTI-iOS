//
//  RankCertificationEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

struct RankCertificationEntity {
    let certificationID, rank: Int
    let certificationName, certificationType: String

    enum CodingKeys: String, CodingKey {
        case certificationID = "certificationId"
        case rank, certificationName, certificationType
    }
}
