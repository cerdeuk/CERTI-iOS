//
//  CareerModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/16/26.
//

import Foundation

struct CareerModel: Identifiable {
    var careerId: Int
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var description: String
    
    var id: Int { careerId }
}


// MARK: - Func

extension CareerModel {
    func toCareersEntity() -> CareerEntity {
        CareerEntity(
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
