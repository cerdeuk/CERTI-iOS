//
//  OnboardingUnivModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

struct OnboardingUnivModel: Identifiable {
    var id: UUID = UUID()
    
    var university: String
}

extension OnboardingUnivModel {
    static func dummy() -> [OnboardingUnivModel] {
        return [
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름"),
            OnboardingUnivModel(university: "대학교 이름")
        ]
    }
}
