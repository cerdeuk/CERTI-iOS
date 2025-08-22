//
//  AcquisitionDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias AcquisitionDetailResponseDTO = BaseResponseDTO<AcquisitionDetailData>

struct AcquisitionDetailData: Decodable {
    let getAcquisitionDetailResponses: [AcquisitionDetailInfo]
}

struct AcquisitionDetailInfo: Decodable {
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let cardBackImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let createdAt: String
}
