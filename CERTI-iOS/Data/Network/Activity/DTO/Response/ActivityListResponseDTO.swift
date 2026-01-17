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

extension ActivityListData {
    func toActivityListEntity() -> ActivityListEntity {
        return ActivityListEntity(
            list: activityDetailResponses.map{ $0.toActivityEntity() }
        )
    }
}

struct Activity: Decodable, Identifiable {
    var id: Int { activityId }
    
    let activityId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    func toActivityEntity() -> ActivityEntity {
        return ActivityEntity(
            activityId: activityId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
