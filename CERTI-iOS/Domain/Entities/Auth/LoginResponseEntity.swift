//
//  LoginResponseEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct LoginResponseEntity: Codable {
    let needSignUp: Bool
    let preSignupToken: String
    let userInformation: UserInformationEntity

    enum CodingKeys: String, CodingKey {
        case needSignUp, preSignupToken, userInformation
    }
}

struct TokenResponseEntity: Codable {
    let accessToken, refreshToken: String
}
