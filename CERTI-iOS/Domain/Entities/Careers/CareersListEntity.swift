//
//  CareersListEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/24/25.
//

import Foundation


struct CareersListEntity {
    let careersList: [CareersListEntityData]
    
    init(careersList: [CareersListEntityData]) {
        self.careersList = careersList
    }
    
    
    // MARK: - Func
    
    func toCareersModel() -> [ResumeModel] {
        return careersList.map { $0.toCareersModel() }
    }
}

struct CareersListEntityData {
    let careerId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    init(careerId: Int, startAt: String, endAt: String, name: String, description: String, place: String) {
        self.careerId = careerId
        self.startAt = startAt
        self.endAt = endAt
        self.name = name
        self.description = description
        self.place = place
    }
    
    // MARK: - Func
    
    func toCareersModel() -> ResumeModel {
        return ResumeModel(
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            discription: description
        )
    }
}
