//
//  FavoriteItem.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

struct FavoriteItem: Identifiable, Hashable {
    let id: Int
    let certificationName: String // 자격증 이름
    let certificationType: String // 자격증 타입 (국가기술자격 등)
    let testType: String          // 시험 타입 (실기/필기)
    let agencyName: String        // 주관사
    var isFavorite: Bool          // 즐겨찾기 여부
}
