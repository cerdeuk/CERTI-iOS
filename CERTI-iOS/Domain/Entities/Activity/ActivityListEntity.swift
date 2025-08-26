//
//  ActivityListEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

struct ActivityListEntity {
    let activityList: [ActivityListEntityData]
    
    init(activityList: [ActivityListEntityData]) {
        self.activityList = activityList
    }
    
    
    // MARK: - Func
    
    func toResumeModel() -> [ResumeModel] {
        return activityList.map { $0.toResumeModel() }
    }
}

struct ActivityListEntityData {
    let activityId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    init(activityId: Int, startAt: String, endAt: String, name: String, description: String, place: String) {
        self.activityId = activityId
        self.startAt = startAt
        self.endAt = endAt
        self.name = name
        self.description = description
        self.place = place
    }
    
    // MARK: - Func
    
    func toResumeModel() -> ResumeModel {
        return ResumeModel(
            activityId: activityId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            discription: description
        )
    }
}
