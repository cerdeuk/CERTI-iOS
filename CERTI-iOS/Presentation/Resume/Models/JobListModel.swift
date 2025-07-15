//
//  JobListModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/15/25.
//

import SwiftUI

struct JobListModel: Identifiable {
    var id: UUID = UUID()
    
    let jobList: [String]
}

extension JobListModel {
    static func myJobListDummy() -> [JobListModel] {
        return [ 
                 JobListModel(jobList: ["재무/세무/IR", "기획/전략", "UX/UI디자인"]),
                 JobListModel(jobList: ["재무/세무/IR", "기획/전략", "UX/UI디자인"]),
                 JobListModel(jobList: ["재무/세무/IR", "기획/전략", "UX/UI디자인"]),
                 JobListModel(jobList: ["재무/세무/IR", "기획/전략", "UX/UI디자인"]),
        ]
    }
}
