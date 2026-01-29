//
//  EditProfileResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

typealias EditProfileResponseDTO = BaseResponseDTO<EditProfileResponseData>

struct EditProfileResponseData: Codable {
    let nickName, name, email: String
    let birthDate: String?
    let profileImageURL: String
    
    func toEditProfileEntity() -> EditProfileEntity {
        return EditProfileEntity(
            nickName: nickName,
            name: name,
            email: email,
            birthDate: birthDate,
            profileImageURL: profileImageURL
        )
    }
}
