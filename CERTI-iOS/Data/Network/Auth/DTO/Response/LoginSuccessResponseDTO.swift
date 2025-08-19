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
}

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
