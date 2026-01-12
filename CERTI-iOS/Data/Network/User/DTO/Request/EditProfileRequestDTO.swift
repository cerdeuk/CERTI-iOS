//
//  EditProfileRequestDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

struct EditProfileRequestDTO: Codable {
    let name, email, nickName: String
    let birthDate: String?
    let publicURL: String
    
    init(entity: EditProfileEntity) {
        self.name = entity.name
        self.email = entity.email
        self.nickName = entity.nickName
        self.birthDate = entity.birthDate
        self.publicURL = entity.profileImageURL
    }
}
