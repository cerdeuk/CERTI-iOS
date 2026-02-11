//
//  LoginResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

typealias LoginResponseDTO = BaseResponseDTO<LoginResponseData>

struct LoginResponseData: Codable {
    // 최초 로그인 시 응답 DTO
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
    
    func toLoginResponseEntity() -> LoginResponseEntity {
        return LoginResponseEntity(
            needSignUp: needSignUp,
            preSignupToken: preSignupToken,
            userInformation: userInformation,
            userID: userID,
            nickName: nickName,
            tokenResponse: tokenResponse
        )
    }
}

struct TokenResponseData: Codable {
    let accessToken, refreshToken: String
    
    func toTokenResponseEntity() -> TokenResponseEntity {
        return TokenResponseEntity(accessToken: accessToken, refreshToken: refreshToken)
    }
}
