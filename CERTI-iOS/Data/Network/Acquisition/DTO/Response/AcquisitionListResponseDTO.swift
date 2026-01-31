//
//  AcquisitionListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

typealias AcquisitionListResponseDTO = BaseResponseDTO<AcquisitionListData>

struct AcquisitionListData: Decodable {
    let acquisitionListDetailResponses: [AcquisitionListInfo]
}

extension AcquisitionListData {
    func toAcquisitionListEntityList() -> AcquisitionListEntity {
        return AcquisitionListEntity(
            acquisitionList: acquisitionListDetailResponses.map{ $0.toAcquisitionListEntityData() }
        )
    }
}

struct AcquisitionListInfo: Decodable {
    let certificationId: Int
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let acquisitionDate: String
    let grade: String?
    let certificationType: String
    
    
    // MARK: - Func
    
    func toAcquisitionListEntityData() -> AcquisitionListEntityData {
        return AcquisitionListEntityData(
            certificationId: certificationId,
            acquisitionId: acquisitionId,
            cardFrontImageUrl: cardFrontImageUrl,
            index: index,
            name: name,
            tags: tags,
            description: description,
            acquisitionDate: acquisitionDate,
            grade: grade,
            certificationType: certificationType
        )
    }
}
