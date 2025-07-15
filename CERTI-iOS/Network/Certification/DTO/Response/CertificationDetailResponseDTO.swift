//
//  CertificationDetailResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import Foundation

typealias CertificationDetailResponseDTO = BaseResponseDTO<SearchCertificationData>

struct CertificationDetailData: Decodable {
    let certificationSimpleList: [LicenseCardModel]
}
