//
//  SignupRequestEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

struct SignupRequestEntity: Codable {
    let userInformation: UserInformationEntity
    let university, grade, track, major: String
    let nickname: String
    let jobs: [String]
}
