//
//  CertificatedModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/10/25.
//

import SwiftUI

struct CertificatedModel: Identifiable {
    var id: UUID = UUID()
    
    let name: String
    let createdAt: String
    let cardFrontImageUrl: String
    let cardBackImageUrl: String
    let tag: [String]
    let cardId: Int
}

extension CertificatedModel {
    static func dummy() -> [CertificatedModel] {
        return [
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_1", cardBackImageUrl: "", tag: ["디자인", "컴퓨터공학"], cardId: 0),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_2", cardBackImageUrl: "", tag: ["디자인", "컴퓨터공학"], cardId: 1),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_3", cardBackImageUrl: "", tag: ["디자인", "컴퓨터공학"], cardId: 2),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_4", cardBackImageUrl: "", tag: ["디자인", "컴퓨터공학"], cardId: 3),
        ]
    }
}
