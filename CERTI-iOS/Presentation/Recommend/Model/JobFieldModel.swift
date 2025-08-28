//
//  JobFieldModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/26/25.
//

import SwiftUI

struct JobFieldModel: Identifiable {
    var id: UUID = UUID()
    
    let jobList: [String]
}

extension JobFieldModel {
    func toJobEntity() -> JobEntity {
        return JobEntity(jobs: jobList)
    }
}
