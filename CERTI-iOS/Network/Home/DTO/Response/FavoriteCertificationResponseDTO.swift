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

struct FavoriteCertificationInfo: Decodable {
    let certificationId: Int
    let certificationName: String
    let testType: String
    let agencyName: String
    let certificationType: String
    let isFavorite: Bool
}

extension FavoriteCertificationInfo {
    func toFavoriteLicenseCardModel() -> FavoriteLicenseCardModel {
        return FavoriteLicenseCardModel(certificationId: self.certificationId, certificationName: self.certificationName, testType: self.testType, agencyName: self.agencyName, certificationType: self.certificationType, isFavorite: self.isFavorite)
    }
}
