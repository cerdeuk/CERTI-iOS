//
//  CategoryListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/15/25.
//

import Foundation

typealias CategoryListResponseDTO = BaseResponseDTO<CategoryListData>

struct CategoryListData: Decodable {
    let certificationSimpleList: [LicenseCardModel]
}
