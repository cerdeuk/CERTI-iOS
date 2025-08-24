//
//  CategoryListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

typealias CategoryListResponseDTO = BaseResponseDTO<CategoryListData>

struct CategoryListData: Decodable {
    let certificationSimpleList: [CategoryCertificationInfo]
}

extension CategoryListData {
    func toEntity() -> CertificationsEntity {
        return CertificationsEntity(
            certifications: certificationSimpleList.map { $0.toEntity() }
        )
    }
}

struct CategoryCertificationInfo: Decodable {
    let certificationId: Int
    let certificationName: String
    let certificationType: String
    let tags: [String]
    let testType: String
    var isFavorite: Bool
}

extension CategoryCertificationInfo {
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
