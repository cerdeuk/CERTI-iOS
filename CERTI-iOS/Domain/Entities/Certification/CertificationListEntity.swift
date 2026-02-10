//
//  CertificationListEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

struct CertificationListEntity {
    let certificationSimpleList: [CertificationList]
    let size: Int
}

struct CertificationList: Codable {
    let certificationID: Int
    let certificationName, certificationType, testType: String
    let tags: [String]
    let description: String
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case certificationID = "certificationId"
        case certificationName, certificationType, testType, tags, description, isFavorite
    }
}
