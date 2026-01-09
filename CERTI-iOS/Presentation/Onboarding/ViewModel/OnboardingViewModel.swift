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
    
    private let fetchMajorListUseCase: FetchMajorListUseCase
    private let fetchUnivListUseCase: FetchUnivListUseCase
    private let signupUseCase: SignUpUseCase
    
    init(
        fetchMajorListUseCase: FetchMajorListUseCase,
        fetchUnivListUseCase: FetchUnivListUseCase,
        signupUseCase: SignUpUseCase
    ) {
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
        self.signupUseCase = signupUseCase
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
        guard let authManger = AuthManager.shared.temporarySignUpData else {return}
        let result = await fetchUnivListUseCase.execute(keyword: keyword, preSignUpToken: authManger.preSignupToken)
        
        switch result {
        case .success(let data):
            self.universityList = data.universityNameList
            logger.debug("✅ getUnivList success: \(data.universityNameList)")
            
        case .failure(let error):
            logger.error("getUnivList failed: \(error.localizedDescription)")
        }
    }
    
    func getMajorList(keyword: String) async {
        guard let authManger = AuthManager.shared.temporarySignUpData else {return}
        let result = await fetchMajorListUseCase.execute(keyword: keyword, preSignUpToken: authManger.preSignupToken)
        
        switch result {
        case .success(let data):
            self.majorList = data.majorNameList
            logger.debug("✅ getMajorList success: \(data.majorNameList)")
        case .failure(let error):
            logger.error("getMajorList failed: \(error.localizedDescription)")
        }
    }
    
    func signUp() async -> Bool {
        guard let authManger = AuthManager.shared.temporarySignUpData else { return false }
        
        let requestData = SignupRequestEntity(
            userInformation: authManger.userInformation,
            university: userUniversity,
            grade: selectedGrade,
            track: selectedTrack,
            major: userMajor,
            nickname: nickname,
            jobs: selectedJobCategory
        )
        
        let result = await signupUseCase.execute(request: requestData, preSignUpToken: authManger.preSignupToken)
        
        switch result {
        case .success(let response):
            logger.info("✅ 회원가입 성공, 유저 ID: \(response.userID)")
            
            let accessToken = response.jwtResponse.accessToken
            let refreshToken = response.jwtResponse.refreshToken
            
            _ = TokenManager.shared.saveTokens(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
            return true
        case .failure(let error):
            logger.error("signUp failed: \(error.localizedDescription)")
            return false
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
