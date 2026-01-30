//
//  MonthlyPreCertificationEntity.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

struct MonthlyPreCertificationEntity {
    let year: Int
    let month: Int
    let days: [HasCertificationDaysEntityData]
}

struct HasCertificationDaysEntityData: Decodable {
    let day: Int
    let count: Int
}
