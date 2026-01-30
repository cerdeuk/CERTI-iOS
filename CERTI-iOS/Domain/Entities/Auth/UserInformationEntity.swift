//
//  UserInformationEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct UserInformationEntity: Codable {
    let socialID: String
    let socialType, email, name: String
    let profileImageURL: String?

    enum CodingKeys: String, CodingKey {
        case socialID = "socialId"
        case socialType, email, name
        case profileImageURL = "profileImageUrl"
    }
}
