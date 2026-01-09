//
//  UserInformationData.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct UserInformationData: Codable {
    let socialID: Int
    let name: String?
    let socialType, email, profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case socialID = "socialId"
        case socialType, email, name
        case profileImageURL = "profileImageUrl"
    }
    
    func toDomain() -> UserInformationEntity {
        return UserInformationEntity(
            socialID: socialID,
            socialType: socialType,
            email: email,
            name: name ?? "",
            profileImageURL: profileImageURL
        )
    }
}
