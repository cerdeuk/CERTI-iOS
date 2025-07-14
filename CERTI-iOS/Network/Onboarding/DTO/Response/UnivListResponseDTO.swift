//
//  UnivListResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

typealias UnivListResponseDTO = BaseResponseDTO<UnivListData>

struct UnivListData: Decodable {
    let universityNameList: [String]
}
