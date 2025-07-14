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
    let tags: [String]
    let description: String
    let cardId: Int
}

extension CertificatedModel {
    static func dummy() -> [CertificatedModel] {
        return [
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_1", cardBackImageUrl: "", tags: ["디자인", "컴퓨터공학"], description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.", cardId: 0,),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_2", cardBackImageUrl: "", tags: ["디자인", "컴퓨터공학"], description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.", cardId: 1),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_3", cardBackImageUrl: "", tags: ["디자인", "컴퓨터공학"], description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.", cardId: 2),
            CertificatedModel(name: "GTQ 1급 (그래픽기술자격)", createdAt: "2025.07.05", cardFrontImageUrl: "image_certification_card_small_4", cardBackImageUrl: "", tags: ["디자인", "컴퓨터공학"], description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.", cardId: 3),
        ]
    }
    
    var displayCreatedAt: String {
        createdAt.toDisplayDateString()
    }
}

