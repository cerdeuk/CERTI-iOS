//
//  MyPageEntity.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import Foundation

struct MyPageEntity {
    let nickname, profileImageURL, email: String
    let jobResponse: JobEntity
    let upCount, acCount, fCount: Int   // 순서대로 취득예정, 취득완료, 즐겨찾기
}
