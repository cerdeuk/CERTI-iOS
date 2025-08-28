//
//  PreCertificationInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

typealias PreCertificationInfoResponseDTO = BaseResponseDTO<PreCertificationData>

struct PreCertificationData: Decodable {
    let data: [CertificationInfoResponseDTO]
}

extension PreCertificationData {
    func toPreCertificationEntity() -> PreCertificationEntity {
        return PreCertificationEntity(
            certifications: data.map { $0.toPreCertificationEntityData() }
        )
    }
}
