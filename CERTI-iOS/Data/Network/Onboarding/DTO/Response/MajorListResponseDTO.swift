//
//  MajorListResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/14/25.
//

import Foundation

typealias MajorListResponseDTO = BaseResponseDTO<MajorListData>

struct MajorListData: Decodable {
    let majorNameList: [String]
    
    func toMajorListEntity() -> MajorListEntity {
        return MajorListEntity(majorNameList: majorNameList)
    }
}
