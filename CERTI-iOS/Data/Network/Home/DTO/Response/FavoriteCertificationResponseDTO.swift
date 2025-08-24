//
//  FavoriteCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/16/25.
//

import Foundation

typealias FavoriteCertificationResponseDTO = BaseResponseDTO<FavoriteCertificationData>

struct FavoriteCertificationData: Decodable {
    let data: [FavoriteCertificationInfo]
}

extension FavoriteCertificationData {
    func toFavoriteCertificationEntity() -> FavoriteCertificationEntity {
        return FavoriteCertificationEntity(
            certifications: data.map { $0.toFavoriteCertificationEntityData() }
        )
    }
}

struct FavoriteCertificationInfo: Decodable {
    let certificationId: Int
    let certificationName: String
    let testType: String
    let agencyName: String
    let certificationType: String
    let isFavorite: Bool
}

extension FavoriteCertificationInfo {
    func toFavoriteCertificationEntityData() -> FavoriteCertificationEntityData {
        return FavoriteCertificationEntityData(
            certificationId: certificationId,
            certificationName: certificationName,
            testType: testType,
            agencyName: agencyName,
            certificationType: certificationType,
            isFavorite: isFavorite
        )
    }
}
