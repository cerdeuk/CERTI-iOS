//
//  RankCeritificateTileModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

struct RankCeritificateTileModel: Identifiable, Codable, Hashable {
    let id: Int
    let rank: Int
    let title: String
    let type: String
}
