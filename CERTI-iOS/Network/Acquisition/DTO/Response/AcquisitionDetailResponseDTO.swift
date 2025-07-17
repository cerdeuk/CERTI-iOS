//
//  AcquisitionDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/17/25.
//

import Foundation

typealias AcquisitionDetailResponseDTO = BaseResponseDTO<CertificatedDetailModel>

struct AcquisitionDetailData: Decodable {
    let getAcquisitionDetailResponses: CertificatedDetailModel
}
