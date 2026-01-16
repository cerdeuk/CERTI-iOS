//
//  ActivityModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/16/26.
//

import Foundation

struct ActivityModel: Identifiable {
    var activityId: Int
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var description: String
    
    var id: Int { activityId }
}

extension ActivityModel {
    
    
    // MARK: - Func
        
    func toActivityEntity() -> ActivityEntity {
        return ActivityEntity(
            data: ResumeEntityData(
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
            )
        )
    }
}
