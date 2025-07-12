//
//  PreLicenseCardModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/9/25.
//

import Foundation

struct PreLicenseCardModel {
    let imageIndex: Int
    let certificationId: Int
    let certificationName: String
    let averagePeriod: String
    let testDate: String
    let agencyName: String
}

extension PreLicenseCardModel {
    static func dummy() -> [PreLicenseCardModel] {
        return [
            PreLicenseCardModel(imageIndex: 0, certificationId: 1, certificationName: "시간디자인산업기사", averagePeriod: "3개월", testDate: "2025.05.27", agencyName: "한국산업인력공단"),
            PreLicenseCardModel(imageIndex: 1, certificationId: 2, certificationName: "시간디자인산업기사", averagePeriod: "3개월", testDate: "2025.05.27", agencyName: "한국산업인력공단"),
            PreLicenseCardModel(imageIndex: 2, certificationId: 3, certificationName: "시간디자인산업기사", averagePeriod: "3개월", testDate: "2025.05.27", agencyName: "한국산업인력공단")
        ]
    }
}
