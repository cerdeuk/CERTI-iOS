//
//  LoginResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

typealias LoginResponseDTO = BaseResponseDTO<LoginResponseData>

struct LoginResponseData: Codable {
    let needSignUp: Bool
    let preSignupToken: String
    let userInformation: UserInformationData

    enum CodingKeys: String, CodingKey {
        case needSignUp, preSignupToken, userInformation
    }
    
    func toLoginResponseEntity() -> LoginResponseEntity {
        return LoginResponseEntity(
            needSignUp: needSignUp,
            preSignupToken: preSignupToken,
            userInformation: userInformation.toUserInformationEntity()
        )
    }
}

struct TokenResponseData: Codable {
    let accessToken, refreshToken: String
    
    func toTokenResponseEntity() -> TokenResponseEntity {
        return TokenResponseEntity(accessToken: accessToken, refreshToken: refreshToken)
    }
}
