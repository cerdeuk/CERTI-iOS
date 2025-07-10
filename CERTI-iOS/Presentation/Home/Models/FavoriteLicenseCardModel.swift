//
//  FavoriteLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import SwiftUI

struct FavoriteLicenseCardModel: Identifiable {
    var id: UUID = UUID()

    let certificationId: Int
    let certificationName: String
    let testType: String
    let agencyName: String
    let certificationType: String
}

extension FavoriteLicenseCardModel {
    static func dummy() -> [FavoriteLicenseCardModel] {
        return [
            FavoriteLicenseCardModel(certificationId: 1, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 2, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 3, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 4, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 5, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 6, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격"),
            FavoriteLicenseCardModel(certificationId: 7, certificationName: "정보처리기사", testType: "실기형", agencyName: "한국산업인력공단", certificationType: "국가기술자격")
        ]
    }
}
