//
//  DailyPreCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

typealias DailyPreCertificationResponseDTO = BaseResponseDTO<DailyPreCertificationData>

struct DailyPreCertificationData: Decodable {
    let date: String
    let certifications: [DailyPreCertificationInfoData]
}

extension DailyPreCertificationData {
    func toDailyPreCertificationEntity() -> DailyPreCertificationEntity {
        return DailyPreCertificationEntity(
            date: date,
            certifications: certifications.map {
                $0.toDailyPreCertificationEntityData()
            }
        )
    }
}

struct DailyPreCertificationInfoData: Decodable {
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
}

extension DailyPreCertificationInfoData {
    func toDailyPreCertificationEntityData() -> DailyPreCertificationEntityData {
        return DailyPreCertificationEntityData(
            certificationId: certificationId,
            certificationName: certificationName,
            tags: tags,
            averagePeriod: averagePeriod,
            charge: charge,
            agencyName: agencyName,
            testType: testType,
            description: description,
            applicationMethod: applicationMethod,
            applicationUrl: applicationUrl,
            expirationPeriod: expirationPeriod,
            city: city,
            state: state,
            testDate: testDate,
            isAcquired: isAcquired
        )
    }
}
