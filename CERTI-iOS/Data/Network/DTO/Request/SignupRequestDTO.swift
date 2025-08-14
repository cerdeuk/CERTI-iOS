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
}

struct UserInformationData: Encodable {
    let email: String
    let nickname: String
    let profileImageUrl: String
}
