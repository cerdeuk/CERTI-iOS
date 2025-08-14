//
//  OnboardingViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

import os

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var searchUnivText: String = ""
    @Published var userUniversity: String = ""
    @Published var selectedGrade: String = ""
    @Published var selectedTrack: String = ""
    @Published var searchMajorText: String = ""
    @Published var userMajor: String = ""
    @Published var selectedJobCategory: [String] = []
    @Published var universityList: [String] = []
    @Published var majorList: [String] = []
    
    private let onboardingService = AppDIContainer.shared.makeOnboardingRepository()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Onboarding")
    
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
    
    @MainActor
    func completeSignUp() async -> Bool {
        AuthManager.shared.applyOnboardingData(from: self)
        let result = await AuthManager.shared.signUp()

        switch result {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
}


// MARK: - Network

extension OnboardingViewModel {
    func getUnivList(keyword: String) async {
        let result = await onboardingService.getSearchUniv(keyword: keyword, preSignUpToken: AuthManager.shared.getPreSignupToken())
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getUnivList: No data received")
                return
            }
            
            self.universityList = data.universityNameList
            logger.debug("✅ getUnivList success: \(data.universityNameList)")
            
        case .failure(let error):
            logger.error("getUnivList failed: \(error.localizedDescription)")
        }
    }
    
    func getMajorList(keyword: String) async {
        let result = await onboardingService.getSearchMajor(keyword: keyword, preSignUpToken: AuthManager.shared.getPreSignupToken())
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getMajorList: No data received")
                return
            }
            
            self.majorList = data.majorNameList
            logger.debug("✅ getMajorList success: \(data.majorNameList)")
            
        case .failure(let error):
            logger.error("getMajorList failed: \(error.localizedDescription)")
        }
    }

}
