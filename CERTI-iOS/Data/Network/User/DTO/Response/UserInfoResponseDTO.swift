//
//  UserInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

typealias UserInfoResponseDTO = BaseResponseDTO<UserInfoData>

struct UserInfoData: Decodable {
    let name: String
    let nickname: String
    let university: String
    let major: String
    let percentage: Int
    let birthDate: String?
    let profileImage: String?
}

extension UserInfoData {
    func toUserInfoEntity() -> UserInfoEntity {
        return UserInfoEntity(
            name: name,
            nickname: nickname,
            university: university,
            major: major,
            percentage: percentage,
            birthDate: birthDate,
            profileImage: profileImage
        )
    }
}
