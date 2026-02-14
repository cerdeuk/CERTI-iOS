//
//  CompletedItem.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

struct CompletedItem: Identifiable, Hashable {
    let id: Int
    let aquisionID: Int
    let name: String              // 자격증 이름
    let categoryText: String      // 카테고리
    let description: String       // 설명
    let formattedDate: String     // 취득 날짜
    let grade: String?            // 점수/등급
}
