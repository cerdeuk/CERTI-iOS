//
//  OnboardingMajorModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

struct OnboardingMajorModel: Identifiable {
    var id: UUID = UUID()
    
    var major: String
}

extension OnboardingMajorModel {
    static func dummy() -> [OnboardingMajorModel] {
        return [
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과"),
            OnboardingMajorModel(major: "컴퓨터 공학과")
        ]
    }
}
