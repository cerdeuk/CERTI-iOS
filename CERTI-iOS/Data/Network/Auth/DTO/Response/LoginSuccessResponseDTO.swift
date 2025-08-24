//
//  LoginSuccessResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

struct LoginSuccessResponseDTO: Decodable {
    let userId: Int
    let nickName: String
    let needSignUp: Bool
    let tokenResponse: TokenResponse?
    
    func toLoginSuccessResponseEntity() -> LoginSuccessResponseEntity {
        return LoginSuccessResponseEntity(
            userId: userId,
            nickName: nickName,
            needSignUp: needSignUp,
            tokenResponseData: tokenResponse?.toTokenResponseData()
        )
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
