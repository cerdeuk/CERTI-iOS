//
//  CareerWriteModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct CareerWriteModel {
    var startAt: String = ""
    var endAt: String = ""
    var name: String = ""
    var place: String = ""
    var description: String = ""
}

extension CareerWriteModel {
    
    
    // MARK: - Func
    
    func toCareerEntity() -> CareerEntity {
        CareerEntity(
            careerId: nil,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
