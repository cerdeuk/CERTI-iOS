//
//  ActivityDetailEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

struct ActivityDetailEntity {
    let activityDetail: [ActivityDetailEntityData]
    
    init(activityDetail: [ActivityDetailEntityData]) {
        self.activityDetail = activityDetail
    }
    
    
    // MARK: - Func
    
    func toActivityModel() -> [ResumeModel] {
        return activityDetail.map { $0.toActivityModel() }
    }
}

struct ActivityDetailEntityData {
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
    
    func toActivityModel() -> ResumeModel {
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
