//
//  MonthlyPreCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

typealias MonthlyPreCertificationResponseDTO = BaseResponseDTO<MonthlyPreCertificationData>

struct MonthlyPreCertificationData: Decodable {
    let year: Int
    let month: Int
    let days: [HasCertificationDaysData]
}

extension MonthlyPreCertificationData {
    func toMonthlyPreCertificationEntity() -> MonthlyPreCertificationEntity {
        return MonthlyPreCertificationEntity(
            year: year,
            month: month,
            days: days.map {
                $0.toHasCertificationDaysEntityData()
            }
        )
    }
}

struct HasCertificationDaysData: Decodable {
    let day: Int
    let count: Int
}

extension HasCertificationDaysData {
    func toHasCertificationDaysEntityData() -> HasCertificationDaysEntityData {
        return HasCertificationDaysEntityData(
            day: day,
            count: count
        )
    }
}
