//
//  UserInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

typealias UserInfoResponseDTO = BaseResponseDTO<UserInfoData>

struct UserInfoData: Decodable {
    let nickname: String
    let university: String
    let major: String
    let percentage: Int
}

extension UserInfoData {
    func toUserInfoEntity() -> UserInfoEntity {
        return UserInfoEntity(name: nickname, university: university, major: major, percentage: percentage)
    }
}
