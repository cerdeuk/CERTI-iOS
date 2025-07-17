//
//  AcquisitionListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import Foundation

typealias AcquisitionListResponseDTO = BaseResponseDTO<AcquisitionListData>

struct AcquisitionListData: Decodable {
    let getAcquisitionResponses: [CertificatedModel]
}
