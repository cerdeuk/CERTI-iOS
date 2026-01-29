//
//  RankCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

typealias RankCertificationResponseDTO = BaseResponseDTO<[RankCertificationResponseData]>

struct RankCertificationResponseData: Codable {
    let certificationID, rank: Int
    let certificationName, certificationType: String

    enum CodingKeys: String, CodingKey {
        case certificationID = "certificationId"
        case rank, certificationName, certificationType
    }
    
    func toRankCertificationEntity() -> RankCertificationEntity {
        return RankCertificationEntity(
            certificationID: certificationID,
            rank: rank,
            certificationName: certificationName,
            certificationType: certificationType
        )
    }
}
