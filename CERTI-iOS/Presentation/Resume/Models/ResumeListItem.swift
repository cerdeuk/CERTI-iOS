//
//  ResumeListItem.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/17/26.
//

import Foundation

protocol ResumeListItem {
    var startAt: String { get }
    var endAt: String { get }
    var name: String { get }
    var place: String { get }
    var description: String { get }
}
