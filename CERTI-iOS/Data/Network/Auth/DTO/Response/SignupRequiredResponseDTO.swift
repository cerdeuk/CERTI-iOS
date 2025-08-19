//
//  SignupRequiredResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/11/25.
//

struct SignupRequiredResponseDTO: Decodable {
    let needSignUp: Bool
    let preSignupToken: String
    let userInformation: UserInformation
}

struct UserInformation: Decodable {
    let email: String
    let nickname: String
    let profileImageUrl: String
}
