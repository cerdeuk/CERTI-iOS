//
//  ActivityEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

struct ActivityEntity {
    let activities: ActivityEntityData
    
    init(activities: ActivityEntityData) {
        self.activities = activities
    }
    
    
    // MARK: - Func
    
    func toAddActivityRequestDTO() -> AddActivityRequestDTO {
        return activities.toAddActivityRequestDTO()
    }
}

struct ActivityEntityData {
    let startAt: String
    let endAt: String
    let place: String
    let name: String
    let description: String
    
    init(startAt: String, endAt: String, place: String, name: String, description: String) {
        self.startAt = startAt
        self.endAt = endAt
        self.place = place
        self.name = name
        self.description = description
    }
    
    
    // MARK: - Func
    
    func toAddActivityRequestDTO() -> AddActivityRequestDTO {
        return AddActivityRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
}
