//
//  EditProfileResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/13/26.
//

import Foundation

typealias EditProfileResponseDTO = BaseResponseDTO<EditProfileResponseData>

struct EditProfileResponseData: Codable {
    let nickName, name, email, birthDate: String
    let profileImageURL: String
}
