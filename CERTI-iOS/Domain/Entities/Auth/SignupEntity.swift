//
//  SignupEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

struct SignupRequiredResponseEntity {
    let needSignUp: Bool
    let preSignupToken: String
    let userInformation: UserInformationEntityData
}

struct SignupRequestEntity {
    let userInformation: UserInformationEntityData
    let university: String
    let grade: String
    let track: String
    let major: String
    let jobs: [String]
    
    func toDTO() -> SignupRequestDTO {
        return SignupRequestDTO(
            userInformation: userInformation.toDTO(),
            university: university,
            grade: grade,
            track: track,
            major: major,
            jobs: jobs
        )
    }
}

struct SignupSuccessUserDataEntity {
    let userId: Int
    let nickName: String
    let university: String
    let trackType: String
    let major: String
    let jobs: [String]
    let jwtResponse: JWTResponseEntityData
}

struct JWTResponseEntityData {
    let accessToken: String
    let refreshToken: String
}

struct UserInformationEntityData {
    let email: String
    let nickname: String
    let profileImageUrl: String
    
    func toDTO() -> UserInformationData {
        return UserInformationData(
            email: email,
            nickname: nickname,
            profileImageUrl: profileImageUrl
        )
    }
}
