//
//  OnboardingViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import Foundation

import os

enum OnboardingViewRoute {
    case navigateToGrade
    case navigateToTrack
    case navigateToMajor
    case navigateToJobCategory
    case navigateToNickName
    case navigateToInfo
    
    case completeOnboarding
    case cancelOnboarding
    
    case onboardingViewRouteReset
    case onboardingViewRoutePop
}

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
    @Published var nickname: String = ""
    @Published var nickNameValid: nickNameValidateCase? = nil
    @Published var onboardingViewRoute: OnboardingViewRoute?
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Onboarding")
    private let authManager = AuthManager.shared
    
    private let fetchMajorListUseCase: FetchMajorListUseCase
    private let fetchUnivListUseCase: FetchUnivListUseCase
    
    init(
        fetchMajorListUseCase: FetchMajorListUseCase,
        fetchUnivListUseCase: FetchUnivListUseCase
    ) {
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
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


// MARK: - Navigation Func

extension OnboardingViewModel {
    
    func navigateToGrade() {
        onboardingViewRoute = .navigateToGrade
    }

    func navigateToTrack() {
        onboardingViewRoute = .navigateToTrack
    }
    
    func navigateToMajor() {
        onboardingViewRoute = .navigateToMajor
    }
    
    func navigateToJobCategory() {
        onboardingViewRoute = .navigateToJobCategory
    }
    
    func navigateToNickName() {
        onboardingViewRoute = .navigateToNickName
    }
    
    func navigateToInfo() {
        onboardingViewRoute = .navigateToInfo
    }
    
    func completeOnboarding() {
        onboardingViewRoute = .completeOnboarding
    }
    
    func cancelOnboarding() {
        onboardingViewRoute = .cancelOnboarding
    }
    
    func onboardingViewRoutePop() {
        onboardingViewRoute = .onboardingViewRoutePop
    }
    
    func onboardingViewRouteReset() {
        onboardingViewRoute = .onboardingViewRouteReset
    }
        
}


// MARK: - Network

extension OnboardingViewModel {
    func getUnivList(keyword: String) async {
        let result = await fetchUnivListUseCase.execute(keyword: keyword, preSignUpToken: authManager.getPreSignupToken())
        
        switch result {
        case .success(let data):
            self.universityList = data.universityNameList
            logger.debug("✅ getUnivList success: \(data.universityNameList)")
            
        case .failure(let error):
            logger.error("getUnivList failed: \(error.localizedDescription)")
        }
    }
    
    func getMajorList(keyword: String) async {
        let result = await fetchMajorListUseCase.execute(keyword: keyword, preSignUpToken: authManager.getPreSignupToken())
        
        switch result {
        case .success(let data):
            self.majorList = data.majorNameList
            logger.debug("✅ getMajorList success: \(data.majorNameList)")
        case .failure(let error):
            logger.error("getMajorList failed: \(error.localizedDescription)")
        }
    }

}


// MARK: - Func

extension OnboardingViewModel {
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
