//
//  JobEntity.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/21/25.
//

import Foundation

struct JobEntity {
    let jobs: [String]
    
    init(jobs: [String]) {
        self.jobs = jobs
    }
    
    
    // MARK: - Func
    
    func toJobListModel() -> JobListModel {
        return JobListModel(jobList: jobs)
    }
    
    func toEditJobRequestDTO() -> EditJobRequestDTO {
        return EditJobRequestDTO(jobNameList: jobs)
    }
}
