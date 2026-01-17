//
//  ActivityEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct ActivityEntity {
    let activityId: Int?
    let startAt: String
    let endAt: String
    let name: String
    let place: String
    let description: String
}

// MARK: - Func

extension ActivityEntity {
    func toAddActivityRequestDTO() -> AddActivityRequestDTO {
        AddActivityRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
    
    func toActivityModel() -> ActivityModel? {
        guard let activityId else { return nil }

        return ActivityModel(
            activityId: activityId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
