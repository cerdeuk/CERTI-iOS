//
//  CareersListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias CareersListResponseDTO = BaseResponseDTO<CareersListData>

struct CareersListData: Decodable {
    let careerDetailResponseList: [CareerDetailResponseDTO]
}

struct CareerDetailResponseDTO: Decodable, Identifiable {
    var id: Int { careerId }
    
    let careerId: Int
    let startAt: String
    let endAt: String
    let name: String
    let description: String
    let place: String
    
    func toCareersDetailEntity() -> CareersDetailEntityData {
        return CareersDetailEntityData(
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
    func toCareersDetailEntityList() -> CareersDetailEntity {
        return CareersDetailEntity(
            careersDetail: careerDetailResponseList.map{ $0.toCareersDetailEntity() }
        )
    }
}
