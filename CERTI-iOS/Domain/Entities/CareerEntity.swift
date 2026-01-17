//
//  CareerEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct CareerEntity {
    let careerId: Int?
    let startAt: String
    let endAt: String
    let name: String
    let place: String
    let description: String
}

// MARK: - Func

extension CareerEntity {
    func toAddCareerRequestDTO() -> AddCareerRequestDTO {
        AddCareerRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
    
    func toEditCareerRequestDTO() -> EditCareerRequestDTO {
        EditCareerRequestDTO(
            startAt: startAt,
            endAt: endAt,
            place: place,
            name: name,
            description: description
        )
    }
    
    func toCareerModel() -> CareerModel? {
        guard let careerId else { return nil }
        
        return CareerModel(
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
