//
//  CareersListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias CareersListResponseDTO = BaseResponseDTO<CareersListData>

struct CareersListData: Decodable {
    let careerDetailResponseList: [Career]
}

struct Career: Decodable, Identifiable {
    var id: Int { careerId }
    
    let careerId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    func toCareersListEntityData() -> CareersListEntityData {
        return CareersListEntityData(
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            description: place,
            place: description
        )
    }
}

extension CareersListData {
    func toCareersListEntity() -> CareersListEntity {
        return CareersListEntity(
            careersList: careerDetailResponseList.map{ $0.toCareersListEntityData() }
        )
    }
}
