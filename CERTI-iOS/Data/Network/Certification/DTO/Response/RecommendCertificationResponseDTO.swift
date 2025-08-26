//
//  RecommendCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

typealias RecommendCertificationResponseDTO = BaseResponseDTO<RecommendCertificationData>

struct RecommendCertificationData: Decodable {
    let recommendationList: [RecommendCertification]
}

extension RecommendCertificationData {
    func toCertificationsEntity() -> CertificationsEntity {
        return CertificationsEntity(
            certifications: recommendationList.map { $0.toCertificationsEntityData() }
        )
    }
}

struct RecommendCertification: Decodable {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let testType: String
    let tags: [String]
    let recommendationScore: Int
    let isFavorite: Bool
}

extension RecommendCertification {
    func toRecommendCertificationEntity() -> RecommendCertificationEntity {
        return RecommendCertificationEntity(
            id: certificationId,
            licenseName: certificationName,
            recommendScore: recommendationScore,
            tagChip: tags
        )
    }
    
    func toCertificationsEntityData() -> CertificationsEntityData {
        return CertificationsEntityData(
            certificationId: certificationId,
            certificationName: certificationName,
            certificationType: certificationType,
            tags: tags,
            testType: testType,
            isFavorite: isFavorite
        )
    }
}
