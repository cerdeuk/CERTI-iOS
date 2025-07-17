//
//  CertificatedDetailModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/18/25.
//

import SwiftUI

struct CertificatedDetailModel: Identifiable, Decodable {
    var id: Int { acquisitionId }
    
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let cardBackImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let createdAt: String
}

