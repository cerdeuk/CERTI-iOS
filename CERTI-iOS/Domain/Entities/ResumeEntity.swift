//
//  ResumeEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/26/25.
//

import Foundation

struct ActivityEntity {
    let data: ResumeEntityData
    
    
    // MARK: - Func
    
    func toAddActivityRequestDTO() -> AddActivityRequestDTO {
        return data.toAddActivityRequestDTO()
    }
}

struct ActivityListEntity {
    let list: [ResumeEntityData]
    
    
    // MARK: - Func
    
    func toResumeModel() -> [ResumeModel] {
        return list.map { $0.toResumeModel() }
    }
}

struct CareersEntity {
    let data: ResumeEntityData
    
    
    // MARK: - Func
    
    func toResumeModel() -> ResumeModel {
        return data.toResumeModel()
    }
    
    func toAddCareerRequestDTO() -> AddCareerRequestDTO {
        return data.toAddCareerRequestDTO()
    }
    
    func toEditCareerRequestDTO() -> EditCareerRequestDTO {
        return data.toEditCareerRequestDTO()
    }
}

struct CareersListEntity {
    let list: [ResumeEntityData]
    
    
    // MARK: - Func
    
    func toResumeModel() -> [ResumeModel] {
        return list.map { $0.toResumeModel() }
    }
}

struct ResumeEntityData {
    var activityId: Int?
    var careerId: Int?
    var startAt: String
    var endAt: String
    var name: String
    var place: String
    var description: String
    
    init(activityId: Int? = nil, careerId: Int? = nil, startAt: String, endAt: String, name: String, place: String, description: String) {
        self.activityId = activityId
        self.careerId = careerId
        self.startAt = startAt
        self.endAt = endAt
        self.name = name
        self.place = place
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
    
    func toResumeModel() -> ResumeModel {
        return ResumeModel(
            activityId: activityId,
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
    
    func toAddCareerRequestDTO() -> AddCareerRequestDTO {
        return AddCareerRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
    
    func toEditCareerRequestDTO() -> EditCareerRequestDTO {
        return EditCareerRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
}
