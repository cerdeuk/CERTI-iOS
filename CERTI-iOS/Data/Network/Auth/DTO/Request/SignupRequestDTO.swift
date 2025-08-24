//
//  SignupRequestDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/13/25.
//

import Foundation

struct SignupRequestDTO: Encodable {
    let userInformation: UserInformationData
    let university: String
    let grade: String
    let track: String
    let major: String
    let jobs: [String]
    
    func toSignupRequestEntity() -> SignupRequestEntity {
        return SignupRequestEntity(
            userInformation: userInformation.toUserInformationEntityData(),
            university: university,
            grade: grade,
            track: track,
            major: major,
            jobs: jobs
        )
    }
}

struct UserInformationData: Encodable {
    let email: String
    let nickname: String
    let profileImageUrl: String
    
    func toUserInformationEntityData() -> UserInformationEntityData {
        return UserInformationEntityData(
            email: email,
            nickname: nickname,
            profileImageUrl: profileImageUrl
        )
    }
}
