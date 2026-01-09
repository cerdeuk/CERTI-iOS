//
//  LoginSuccessResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation


struct LoginSuccessResponseDTO: Decodable {
    let status: Int
    let message: String
    let data: LoginSuccessResponseData
    
    func toLoginSuccessResponseEntity() -> LoginSuccessResponseEntity {
        return LoginSuccessResponseEntity(
            userId: data.userID,
            nickName: data.nickName,
            needSignUp: data.needSignUp,
            tokenResponseData: data.tokenResponse.toTokenResponseData()
        )
    }
}

struct LoginSuccessResponseData: Decodable {
    let userID: Int
    let nickName: String
    let needSignUp: Bool
    let preSignupToken: String
    let tokenResponse: TokenResponse
    let userInformation: LoginSuccessUserInformation

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickName, needSignUp, preSignupToken, tokenResponse, userInformation
    }
}

struct LoginSuccessUserInformation: Decodable {
    let socialID: Int
    let socialType, email, name, profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case socialID = "socialId"
        case socialType, email, name
        case profileImageURL = "profileImageUrl"
    }
}

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    func toTokenResponseData() -> TokenResponseData {
        return TokenResponseData(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}



