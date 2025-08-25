//
//  LoginSuccessResponseEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

struct LoginSuccessResponseEntity {
    let userId: Int
    let nickName: String
    let needSignUp: Bool
    let tokenResponseData: TokenResponseData?
}

struct TokenResponseData {
    let accessToken: String
    let refreshToken: String
}
