//
//  SignupResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

typealias SignupResponseDTO = BaseResponseDTO<SignupResponseData>

struct SignupResponseData: Codable {
    let userID: Int
    let nickName, university, trackType, major: String
    let jobs: [String]
    let jwtResponse: JwtResponseData

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickName, university, trackType, major, jobs, jwtResponse
    }
    
    func toSignupResponseEntity() -> SignupResponseEntity {
        return SignupResponseEntity(
            userID: userID,
            nickName: nickName,
            university: university,
            trackType: trackType,
            major: major,
            jobs: jobs,
            jwtResponse: jwtResponse.toJwtResponseEntity()
        )
    }
}

struct JwtResponseData: Codable {
    let accessToken, refreshToken: String
    
    func toJwtResponseEntity() -> JwtResponseEntity {
        return JwtResponseEntity(accessToken: accessToken, refreshToken: refreshToken)
    }
}
