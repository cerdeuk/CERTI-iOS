//
//  UserInfoEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

struct UserInfoEntity {
    let name: String
    let university: String
    let major: String
    let percentage: Int
    
    func toHomeStateModel() -> HomeStateModel {
        return HomeStateModel(username: name, userUniversity: university, userDepartment: major, progressValue: percentage)
    }
}
