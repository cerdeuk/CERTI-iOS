//
//  SignupSuccessResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

typealias SignupSuccessResponseDTO = BaseResponseDTO<SignupUserData>

struct SignupUserData: Decodable {
    let userId: Int
    let nickName: String
    let university: String
    let trackType: String
    let major: String
    let jobs: [String]
    let jwtResponse: JWTResponse
    
    func toSignupSuccessUserDataEntity() -> SignupSuccessUserDataEntity {
        return SignupSuccessUserDataEntity(
            userId: userId,
            nickName: nickName,
            university: university,
            trackType: trackType,
            major: major,
            jobs: jobs,
            jwtResponse: jwtResponse.toTokenResponseData()
        )
    }
}

struct JWTResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    func toTokenResponseData() -> TokenResponseData {
        return TokenResponseData(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
