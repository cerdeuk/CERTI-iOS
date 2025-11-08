//
//  ResumeModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeModel: Identifiable {
    var id: UUID = UUID()
    
    var activityId: Int?
    var careerId: Int?
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var description: String
}

extension ResumeModel {
    
    
    // MARK: - Func
    
    func toCareersEntity() -> CareersEntity {
        return CareersEntity(
            data: ResumeEntityData(
                startAt: startAt,
                endAt: endAt,
                name: name,
                place: place,
                description: description
            )
        )
    }
    
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
