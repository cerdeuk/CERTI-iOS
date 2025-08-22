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
    
    func toEntity() -> LoginSuccessResponseEntity {
        return LoginSuccessResponseEntity(
            userId: userId,
            nickName: nickName,
            needSignUp: needSignUp,
            tokenResponseData: tokenResponse?.toEntity()
        )
    }
}

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    func toEntity() -> TokenResponseData {
        return TokenResponseData(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
