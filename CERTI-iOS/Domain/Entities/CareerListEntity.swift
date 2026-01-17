//
//  CareerListEntity.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

struct CareerListEntity {
    let list: [CareerEntity]
}

extension CareerListEntity {
    func toCareerModels() -> [CareerModel] {
        list.map { $0.toCareerModel() }
    }
}
