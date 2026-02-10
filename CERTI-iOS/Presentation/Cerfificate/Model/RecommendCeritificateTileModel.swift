//
//  RecommendCeritificateTileModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

struct RecommendCeritificateTileModel: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let score: Int
    let description: String
    let tags: [String]
}
