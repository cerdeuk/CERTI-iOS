//
//  AcquisitionListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

typealias AcquisitionListResponseDTO = BaseResponseDTO<AcquisitionListData>

struct AcquisitionListData: Decodable {
    let acquisitionListResponses: [AcquisitionListInfo]
}

struct AcquisitionListInfo: Decodable {
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let createdAt: String
    
    
    // MARK: - Func
    
    func toAcquisitionListEntity() -> AcquisitionListEntityData {
        return AcquisitionListEntityData(
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            createdAt: createdAt
        )
    }
}

extension AcquisitionListData {
    func toAcquisitionListEntityList() -> AcquisitionListEntity {
        return AcquisitionListEntity(acquisitionList: acquisitionListResponses.map{ $0.toAcquisitionListEntity() })
    }
}


