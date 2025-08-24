//
//  CareersEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation

struct CareersEntity {
    let careers: CareersEntityData
    
    init(careers: CareersEntityData) {
        self.careers = careers
    }
    
    
    // MARK: - Func
    
    func toResumeModel() -> ResumeModel {
        return careers.toResumeModel()
    }
}

struct CareersEntityData {
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
    
    func toResumeModel() -> ResumeModel {
        return ResumeModel(startAt: startAt,
                           endAt: endAt,
                           name: name,
                           place: place,
                           discription: description
        )
    }
}
