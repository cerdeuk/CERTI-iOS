//
//  JobCategory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/9/25.
//


enum JobCategory: String, CaseIterable, Identifiable {
    case business = "경영/사무"
    case marketing = "마케팅/광고/홍보"
    case trade = "무역/유통"
    case it = "IT/인터넷"
    case manufacture = "생산/제조"
    case sales = "영업/고객상담"
    case construction = "건설"
    case finance = "금융"
    case rnd = "연구개발/설계"
    case design = "디자인"
    case media = "미디어"
    case professional = "전문/특수직"

    var id: String { self.rawValue }

    var description: String {
        return self.rawValue
    }
}
