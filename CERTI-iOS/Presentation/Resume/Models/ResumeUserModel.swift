//
//  ResumeUserModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 2/9/26.
//

import Foundation

struct ResumeUserModel {
    let name, university, major, profileImage: String
    let birthDate: String?
    
    var birthDateAgeText: String {
            guard let birthDate else { return "-" }
            return birthDate.toBirthDateString()
        }
}
