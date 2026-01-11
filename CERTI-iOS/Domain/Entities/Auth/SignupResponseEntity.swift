//
//  SignupResponseEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct SignupResponseEntity: Codable {
    let userID: Int
    let nickName, university, trackType, major: String
    let jobs: [String]
    let jwtResponse: JwtResponseEntity

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickName, university, trackType, major, jobs, jwtResponse
    }
}

struct JwtResponseEntity: Codable {
    let accessToken, refreshToken: String
}
