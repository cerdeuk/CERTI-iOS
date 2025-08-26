//
//  ActivityListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias ActivityListResponseDTO = BaseResponseDTO<ActivityListData>

struct ActivityListData: Decodable {
    let activityDetailResponses: [Activity]
}

struct Activity: Decodable, Identifiable {
    var id: Int { activityId }

    let activityId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    func toActivityListEntityData() -> ActivityListEntityData {
        return ActivityListEntityData(
            activityId: activityId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            description: place,
            place: description
        )
    }
}

extension ActivityListData {
    func toActivityListEntity() -> ActivityListEntity {
        return ActivityListEntity(
            activityList: activityDetailResponses.map{ $0.toActivityListEntityData() }
        )
    }
}
