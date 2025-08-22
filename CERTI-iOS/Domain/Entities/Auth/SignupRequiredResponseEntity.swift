//
//  SignupRequiredResponseEntity.swift
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

struct UserInformationEntityData {
    let email: String
    let nickname: String
    let profileImageUrl: String
}
