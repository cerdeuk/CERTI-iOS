//
//  LoginResponseEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct LoginResponseEntity: Codable {
    let needSignUp: Bool
    let preSignupToken: String?
    let userInformation: UserInformationData?
    let userID: Int?
    let nickName: String?
    let tokenResponse: TokenResponseData?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickName, needSignUp, preSignupToken, tokenResponse, userInformation
    }
}

struct TokenResponseEntity: Codable {
    let accessToken, refreshToken: String
}
