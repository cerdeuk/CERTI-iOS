//
//  SearchCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import Foundation

typealias SearchCertificationResponseDTO = BaseResponseDTO<SearchCertificationData>

struct SearchCertificationData: Decodable {
    let certificationSimpleList: [SearchCertificationInfo]
}

extension SearchCertificationData {
    func toEntity() -> CertificationsEntity {
        return CertificationsEntity(
            certifications: certificationSimpleList.map { $0.toEntity() }
        )
    }
}

struct SearchCertificationInfo: Decodable {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let tags: [String]
    let testType: String
    var isFavorite: Bool
}

extension SearchCertificationInfo {
    func toEntity() -> CertificationsEntityData {
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
