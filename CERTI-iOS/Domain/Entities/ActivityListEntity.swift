//
//  ActivityListEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct ActivityListEntity {
    let list: [ActivityEntity]
}

extension ActivityListEntity {
    func toActivityModels() -> [ActivityModel] {
        list.compactMap { $0.toActivityModel() }
    }
}
