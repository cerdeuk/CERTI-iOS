//
//  JobListResponseDTO.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import Foundation

typealias JobListResponseDTO = BaseResponseDTO<JobListData>

struct JobListData: Decodable {
    let jobList: [String]
}

extension JobListData {
    func toJobEntity() -> JobEntity {
        return JobEntity(jobs: jobList)
    }
}
