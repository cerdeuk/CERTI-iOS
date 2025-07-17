//
//  AcquisitionDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias AcquisitionDetailResponseDTO = BaseResponseDTO<CertificatedModel>

struct AcquisitionDetailData: Decodable {
    let getAcquisitionResponses: CertificatedModel
}
