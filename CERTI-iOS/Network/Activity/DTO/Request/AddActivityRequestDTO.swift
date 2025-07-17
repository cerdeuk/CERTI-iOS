//
//  AddActivityRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

struct AddActivityRequestDTO: Encodable {
    let startAt: String
    let endAt: String
    let place: String
    let name: String
    let description: String
}
