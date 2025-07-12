//
//  RecommendDetailModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/12/25.
//

import SwiftUI

struct RecommendDetailModel: Identifiable {
    let id: UUID = UUID()
    
    let certificationName: String
    let tags: [String]
    let averagePeriod: String
    let charge: Int
    let agency: String
    let testType: String
    let description: String
    let testDateInformation: String
    let applicationMethod: String
    let applicationUrl: String
    let expirationPeriod: String
}

extension RecommendDetailModel {
    static func dummy() -> RecommendDetailModel {
        return .init(
            certificationName: "정보처리기사",
            tags: ["컴퓨터공학", "시각디자인", "경영"],
            averagePeriod: "12개월",
            charge: 100000,
            agency: "한국정보기술진흥원",
            testType: "실기형",
            description: "2D 그래픽 툴의 기능을 활용한 사고의 시각화를 통해 이미지 제작, 수정, 편집 및 그래픽 디자인을 창출하는 업무를 수행하고 이를 통해 비지니스 커뮤니케이션을 원활하게 한다. 1급과 2급, 급수의 차이는 이 업무를 수행하는 툴 활용 능력의 범위와 숙련도 등의 고도화 차이이다.",
            testDateInformation: "매월 넷째주 토요일 정기시험 시행 (총 12회)",
            applicationMethod: "온라인(한국생산성본부 홈페이지)",
            applicationUrl: "https://www.kisa.or.kr/",
            expirationPeriod: "1년"
        )
    }
}
