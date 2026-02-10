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

extension CareersListData {
    func toCareersListEntity() -> CareerListEntity {
        return CareerListEntity(
            list: careerDetailResponseList.map{ $0.toCareerEntity() }
        )
    }
}

struct Career: Decodable, Identifiable {
    var id: Int { careerId }
    
    let careerId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    func toCareerEntity() -> CareerEntity {
        return CareerEntity(
            careerId: careerId,
            startAt: startAt,
            endAt: endAt,
            name: name,
            place: place,
            description: description
        )
    }
}
