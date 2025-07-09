//
//  LicenseCardModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import Foundation

struct LicenseCardModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let subtitle: String
    let tagList: [String]
    let type: String
    var isFavorite: Bool
}
        
extension LicenseCardModel {
    // TODO: - 명세서 나오면 변수명 바꿉니다잉~
    static func dummy() -> [LicenseCardModel] {
        return [
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: true),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            LicenseCardModel(title: "정보처리기사", subtitle: "국가기술자격", tagList: ["컴퓨터공학", "시각디자인", "경영"], type: "실기형", isFavorite: false),
            ]
    }
}
