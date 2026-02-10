//
//  ActivityWriteModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct ActivityWriteModel {
    var startAt: String = ""
    var endAt: String = ""
    var name: String = ""
    var place: String = ""
    var description: String = ""
}

extension ActivityWriteModel {
    
    
    // MARK: - Func
        
    func toActivityEntity() -> ActivityEntity {
        ActivityEntity(
            activityId: nil,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
