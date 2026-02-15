//
//  DailyPreCertificationEntity.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

struct DailyPreCertificationEntity {
    let date: String
    let certifications: [DailyPreCertificationEntityData]
}

struct DailyPreCertificationEntityData {
    let certificationId: Int
    let certificationName: String
    let tags: [String]
    let averagePeriod: String
    let charge: String
    let agencyName: String
    let testType: String
    let description: String
    let applicationMethod: String
    let applicationUrl: String
    let expirationPeriod: String
    let city: String
    let state: String
    let testDate: String
    let isAcquired: Bool
    let certificationType: String
}

extension DailyPreCertificationEntityData {
    func toCalendarPreLicenseCardModel() -> CalendarPreLicenseCardModel {
        return CalendarPreLicenseCardModel(
            certificationId: certificationId,
            location: city,
            time: testDate,
            title: certificationName,
            category: certificationType,
            description: description
        )
    }
}
