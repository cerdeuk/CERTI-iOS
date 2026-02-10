//
//  UserInfoResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

typealias UserInfoResponseDTO = BaseResponseDTO<UserInfoData>

struct UserInfoData: Decodable {
    let userId: Int
    let nickname: String
    let name: String
    let university: String
    let major: String
    let job: String
    let profileImage: String
    let birthDate: String?
    let percentage: Int
}

extension UserInfoData {
    func toUserInfoEntity() -> UserInfoEntity {
        return UserInfoEntity(name: name, university: university, major: major, percentage: percentage, birthDate: birthDate ?? nil)
    }
}
