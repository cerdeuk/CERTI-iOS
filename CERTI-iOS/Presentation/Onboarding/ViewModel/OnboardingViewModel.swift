//
//  OnboardingViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var searchUnivText: String = ""
    @Published var userUniversity: String = ""
    
    @Published var selectedGrade: String = ""
    
    @Published var selectedTrack: String = ""
    
    @Published var searchMajorText: String = ""
    @Published var userMajor: String = ""
    
    @Published var selectedJobCategory: [String] = []
    
    func searchUnivValidate() -> Bool {
        let searchTextValid = !searchUnivText.trimmingCharacters(in: .whitespaces).isEmpty
        let userUniversityValid = !userUniversity.trimmingCharacters(in: .whitespaces).isEmpty

        return searchTextValid && userUniversityValid
    }
    
    func searchMajorValidate() -> Bool {
        let searchTextValid = !searchMajorText.trimmingCharacters(in: .whitespaces).isEmpty
        let userMajorValid = !userMajor.trimmingCharacters(in: .whitespaces).isEmpty

        return searchTextValid && userMajorValid
    }
    
}
