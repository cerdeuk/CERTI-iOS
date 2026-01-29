//
//  CertificationListResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

typealias CertificationListResponseDTO = BaseResponseDTO<CertificationListResponseData>

struct CertificationListResponseData: Codable {
    let certificationSimpleList: [CertificationSimpleList]
    let size: Int
    
    func toCertificationListEntity() -> CertificationListEntity {
        return CertificationListEntity(certificationSimpleList: certificationSimpleList.map{ $0.toCertificationList() }, size: size)
    }
}

struct CertificationSimpleList: Codable {
    let certificationID: Int
    let certificationName, certificationType, testType: String
    let tags: [String]
    let description: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case certificationID = "certificationId"
        case certificationName, certificationType, testType, tags, description, isFavorite
    }
    
    func toCertificationList() -> CertificationList {
        return CertificationList(
            certificationID: certificationID,
            certificationName: certificationName,
            certificationType: certificationType,
            testType: testType,
            tags: tags,
            description: description,
            isFavorite: isFavorite
        )
    }
}
