//
//  EditActivityRequestDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/26/26.
//

import Foundation

struct EditActivityRequestDTO: Encodable {
    let startAt: String
    let endAt: String
    let place: String
    let name: String
    let description: String
}
