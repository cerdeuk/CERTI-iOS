//
//  SearchCertificationResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import Foundation

typealias SearchCertificationResponseDTO = BaseResponseDTO<SearchCertificationData>

struct SearchCertificationData: Decodable {
    let certificationSimpleList: [LicenseCardModel]
}
