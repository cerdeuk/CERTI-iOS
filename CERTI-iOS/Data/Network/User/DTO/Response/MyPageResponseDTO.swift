//
//  MyPageResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import Foundation

typealias MyPageResponseDTO = BaseResponseDTO<MyPageResponseData>

struct MyPageResponseData: Codable {
    let nickname, profileImageURL, email: String
    let jobResponse: JobResponseData
    let upCount, acCount, fCount: Int
}

struct JobResponseData: Codable {
    let jobList: [String]
}
