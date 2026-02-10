//
//  EditCareerRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/15/26.
//

import Foundation

struct EditCareerRequestDTO: Encodable {
    let startAt: String
    let endAt: String
    let place: String
    let name: String
    let description: String
}
