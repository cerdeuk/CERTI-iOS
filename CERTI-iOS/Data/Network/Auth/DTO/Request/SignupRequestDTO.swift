//
//  SignupRequestDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct SignupRequestDTO: Codable {
    let userInformation: UserInformationData
    let university, grade, track, major: String
    let nickname: String
    let jobs: [String]
    
    func toDomain() -> SignupRequestEntity {
        return SignupRequestEntity(
            userInformation: userInformation.toDomain(),
            university: university,
            grade: grade,
            track: track,
            major: major,
            nickname: nickname,
            jobs: jobs
        )
    }
}
