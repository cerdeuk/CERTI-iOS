//
//  ExpectedItem.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

struct ExpectedItem: Identifiable, Hashable {
    let id: Int
    let certificationName: String // 자격증 이름
    let agencyName: String        // 주관사 (카테고리 대용)
    let averagePeriod: String     // 준비 기간
    let description: String       // 설명
    let city: String              // 장소 (시)
    let state: String             // 장소 (구)
    let formattedTime: String     // 시간
}
