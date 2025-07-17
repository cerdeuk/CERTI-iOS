//
//  CertificatedListModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/10/25.
//

import SwiftUI

struct CertificatedListModel: Identifiable, Decodable {
    var id: Int { acquisitionId }
    
    let acquisitionId: Int
    let cardFrontImageUrl: String
    let index: Int
    let name: String
    let tags: [String]
    let description: String
    let createdAt: String
}

extension CertificatedListModel {
    static func dummy() -> [CertificatedListModel] {
        return [
            CertificatedListModel(
                acquisitionId: 0,
                cardFrontImageUrl: "image_certification_card_large_1",
                index: 0,
                name: "GTQ 1급 (그래픽기술자격)",
                tags: ["디자인", "컴퓨터공학"],
                description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.",
                createdAt: "2025.07.05"
            ),
            CertificatedListModel(
                acquisitionId: 1,
                cardFrontImageUrl: "image_certification_card_large_2",
                index: 1,
                name: "컴퓨터활용능력 1급",
                tags: ["문서작성", "오피스"],
                description: "스프레드시트와 데이터베이스 활용에 대한 능력을 평가하는 시험으로, 기업 및 공공기관의 정보 업무 능력을 갖추었는지를 판단하는 자격이다.",
                createdAt: "2025.06.28"
            ),
            CertificatedListModel(
                acquisitionId: 2,
                cardFrontImageUrl: "image_certification_card_large_3",
                index: 2,
                name: "정보처리기사",
                tags: ["개발", "자격증"],
                description: "정보시스템에 대한 분석, 설계, 구현, 테스트 및 운영과 관련된 업무를 수행할 수 있는 능력을 평가하는 자격시험이다.",
                createdAt: "2025.06.15"
            ),
            CertificatedListModel(
                acquisitionId: 3,
                cardFrontImageUrl: "image_certification_card_large_4",
                index: 3,
                name: "SQLD",
                tags: ["데이터베이스", "SQL"],
                description: "데이터베이스 설계 및 운용 능력을 평가하는 자격시험으로, 관계형 데이터 모델에 대한 이해와 SQL을 활용한 질의 능력을 중심으로 한다.",
                createdAt: "2025.05.30"
            )
        ]
    }
    
    var displayCreatedAt: String {
        createdAt.toDisplayDateString()
    }
}
