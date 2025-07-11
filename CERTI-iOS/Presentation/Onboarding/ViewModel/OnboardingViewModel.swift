//
//  OnboardingViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var userUniversity: String = ""
    
    func searchValidate() -> Bool {
        let searchTextValid = !searchText.trimmingCharacters(in: .whitespaces).isEmpty
        let userUniversityValid = !userUniversity.trimmingCharacters(in: .whitespaces).isEmpty

        return searchTextValid && userUniversityValid
    }
}
