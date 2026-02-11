//
//  CertificateListTileModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import Foundation

struct CertificateListTileModel: Identifiable, Codable, Hashable {
    let id: Int                 // 자격증 고유 ID (ViewModel의 selectedCertificateId와 매칭)
    let title: String           // 자격증 이름 (예: 정보처리기사)
    let type: String            // 자격증 분류 (예: 국가기술자격)
    let description: String     // 설명
    let tags: [String]          // 태그 리스트 (예: ["컴퓨터공학", "경영"])
    let testType: String        // 시험 방식 (예: 실기형)
    var isFavorite: Bool        // 즐겨찾기 여부 (변경 가능해야 하므로 var)
}

// MARK: - Dummy Data (프리뷰 및 테스트용)
extension CertificateListTileModel {
    static let dummyData: [CertificateListTileModel] = [
        CertificateListTileModel(
            id: 1,
            title: "정보처리기사",
            type: "국가기술자격",
            description: "기업체 전산실, 소프트웨어 개발업체, SI(system integrated)업체 (정보통신, 시스템 구축회사 등), 정부기관 등에서 활동합니다.",
            tags: ["컴퓨터공학", "시각디자인", "경영"],
            testType: "실기형",
            isFavorite: true
        ),
        CertificateListTileModel(
            id: 2,
            title: "SQLD",
            type: "데이터자격시험",
            description: "데이터베이스와 데이터 모델링에 대한 지식을 바탕으로 데이터를 조작하고 추출하는데 능숙해야 합니다.",
            tags: ["컴퓨터공학", "통계학"],
            testType: "필기형",
            isFavorite: false
        ),
        CertificateListTileModel(
            id: 3,
            title: "컴퓨터활용능력 1급",
            type: "국가기술자격",
            description: "스프레드시트, 데이터베이스 활용 능력을 평가하는 국가기술자격 시험입니다.",
            tags: ["공통", "사무"],
            testType: "실기/필기",
            isFavorite: false
        )
    ]
}
