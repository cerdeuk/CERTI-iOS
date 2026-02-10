//
//  MyPageResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import Foundation

typealias MyPageResponseDTO = BaseResponseDTO<MyPageResponseData>

struct MyPageResponseData: Codable {
    let nickname, email: String
    let profileImageURL: String?
    let jobResponse: JobResponseData
    let upCount, acCount, fCount: Int
    
    func toMyPageEntity() -> MyPageEntity {
        return MyPageEntity(
            nickname: nickname,
            email: email,
            profileImageURL: profileImageURL,
            jobResponse: jobResponse.toJobEntity(),
            upCount: upCount,
            acCount: acCount,
            fCount: fCount
        )
    }
}

struct JobResponseData: Codable {
    let jobList: [String]
    
    func toJobEntity() -> JobEntity {
        return JobEntity(jobs: jobList)
    }
}
