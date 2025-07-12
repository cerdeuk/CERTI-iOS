//
//  LicenseCardModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import Foundation

struct LicenseCardModel: Identifiable {
    let id: UUID = UUID()
    let certificationName: String
    let certificationType: String
    let tags: [String]
    let testType: String
    var isFavorite: Bool
}
        
extension LicenseCardModel {
    // TODO: - 명세서 나오면 변수명 바꿉니다잉~
    static func dummy() -> [LicenseCardModel] {
        return [
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: true),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            LicenseCardModel(certificationName: "정보처리기사", certificationType: "국가기술자격", tags: ["컴퓨터공학", "시각디자인", "경영"], testType: "실기형", isFavorite: false),
            ]
    }
}
