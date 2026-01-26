//
//  MyPageViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

import os

enum MyPageViewRoute {
    case navigateToEditProfile
    case navigateToManageAcademicInfo
    case navigateToEditUniversity
    case navigateToEditMajor
    case navigateToManageCertificates
    case navigateToSettings
    case navigateToNotificationSettings
    case navigateToEditExpectedCertificate
    case navigateToEditCompletedCertificate
    
    case myPageViewRoutePop
}

@MainActor
final class MyPageViewModel: ObservableObject {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "MyPage")
    
    //MARK: - Property Wrappers
    
    @Published var myPageViewRoute: MyPageViewRoute?
    @Published var userName: String = "김한열"
    @Published var userNickName: String = "김서티" {
        didSet {
            if oldValue != userNickName {
                nickNameValid = nil
            }
        }
    }
    @Published var nickNameValid: nickNameValidateCase? = nil

    @Published var userEmail: String = "certification@gmail.com"
    @Published var profileImageURL: String = ""
    @Published var jobCategoryList: [JobCategory] = []
    @Published var upCertificationCount: Int = 0
    @Published var acCertificationCount: Int = 0
    @Published var fCertificationCount: Int = 0
    
    @Published var userBirth: Date? = nil
    
    @Published var expectedList: [ExpectedItem] = []
    @Published var editingExpectedItem: ExpectedItem? = nil
    
    @Published var completedList: [CompletedItem] = []
    @Published var editingCompletedItem: CompletedItem? = nil
    
    @Published var favoriteList: [FavoriteItem] = []
    @Published var universityList: [String] = []
    @Published var majorList: [String] = []
    
    //MARK: - UseCases
    
    private let fetchMyPageInfoUseCase: FetchMyPageInfoUseCase
    private let fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase
    private let checkNickNameUseCase: CheckNickNameUseCase
    private let updateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase
    private let editJobUseCase: EditJobUseCase
    private let fetchMajorListUseCase: FetchMyPageMajorListUseCase
    private let fetchUnivListUseCase: FetchMyPageUnivListUseCase
    private let editMajorUseCase: EditMajorUseCase
    private let editUnivUseCase: EditUnivUseCase
    
    //MARK: - Properties

    private var initialProfile: ProfileSnapshot?
    
    private struct ProfileSnapshot: Equatable {
        let nickName: String
        let name: String
        let email: String
        let birth: Date?
        let profileImageURL: String
    }
    
    var isProfileModified: Bool {
        guard let initial = initialProfile else { return false }
        
        let current = ProfileSnapshot(
            nickName: userNickName,
            name: userName,
            email: userEmail,
            birth: userBirth,
            profileImageURL: profileImageURL
        )
        
        return initial != current
    }
    
    var isProfileSaveEnabled: Bool {
        guard isProfileModified else { return false }
        
        guard let initial = initialProfile else { return false }
        
        if userNickName != initial.nickName {
            return nickNameValid == .valid
        } else {
            return true
        }
    }

    // MARK: - init
    
    init(
        fetchMyPageInfoUseCase: FetchMyPageInfoUseCase,
        fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase,
        checkNickNameUseCase: CheckNickNameUseCase,
        updateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase,
        editJobUseCase: EditJobUseCase,
        fetchMajorListUseCase: FetchMyPageMajorListUseCase,
        fetchUnivListUseCase: FetchMyPageUnivListUseCase,
        editMajorUseCase: EditMajorUseCase,
        editUnivUseCase: EditUnivUseCase
    ) {
        self.fetchMyPageInfoUseCase = fetchMyPageInfoUseCase
        self.fetchEditProfileInfoUseCase = fetchEditProfileInfoUseCase
        self.checkNickNameUseCase = checkNickNameUseCase
        self.updateEditProfileInfoUseCase = updateEditProfileInfoUseCase
        self.editJobUseCase = editJobUseCase
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
        self.editMajorUseCase = editMajorUseCase
        self.editUnivUseCase = editUnivUseCase

        loadDummyData()
    }
    
}


// MARK: - Func

extension MyPageViewModel {
    func fetchMyPageInfo() async {
        let result = await fetchMyPageInfoUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchMyPageInfo success: 닉네임 - \(response.nickname)")
            convertToMyPageInfo(entity: response)
        case .failure(let error):
            logger.error("❌ fetchMyPageInfo failed: \(error.localizedDescription)")
        }
    }
    
    func fetchEditProfileInfo() async {
        let result = await fetchEditProfileInfoUseCase.execute()

        switch result {
        case .success(let response):
            logger.debug("✅ fetchEditProfileInfo success: 이름 - \(response.name)")
            convertToEditProfileInfo(entity: response)
        case .failure(let error):
            logger.error("❌ fetchMyPageInfo failed: \(error.localizedDescription)")
        }
    }
    
    func checkNickNameValidate() async {
        let result = await checkNickNameUseCase.execute(nickname: userNickName)
        
        switch result {
        case .success(let response):
            logger.debug("✅ checkNickNameValidate success: \(response.description)")
            AuthManager.shared.nickname = userNickName
            nickNameValid = .valid
        case .failure(let error):
            var errorMessage = ""
            
            switch error {
            case .apiError(let message):
                errorMessage = message
            default:
                errorMessage = error.localizedDescription
            }
            
            logger.error("닉네임 검증 실패: \(errorMessage)")
            
            if errorMessage.contains("존재하는") {
                nickNameValid = .duplicate
            } else if errorMessage.contains("비속어") {
                nickNameValid = .abuse
            } else if errorMessage.contains("공백") {
                nickNameValid = .empty
            } else {
                logger.error("처리되지 않은 에러 메시지: \(errorMessage)")
            }
        }
    }
    
    func editProfileInfo() async {
        let result = await updateEditProfileInfoUseCase.execute(info: convertToEditProfileEntity())
        
        switch result {
        case .success:
            logger.debug("✅ editProfileInfo success")
            await fetchMyPageInfo()
        case .failure(let error):
            logger.error("❌ fetchMyPageInfo failed: \(error.localizedDescription)")
        }
    }
    
    func deleteCompletedCertificate(id: UUID) {
        print("취득 완료 삭제: \(id)")
        completedList.removeAll { $0.id == id }
    }
    
    func deleteExpectedCertificate(id: UUID) {
        print("취득 예정 삭제: \(id)")
        expectedList.removeAll { $0.id == id }
    }
    
    func editCertificate(id: UUID) {
        print("수정 요청: \(id)")
    }
    
    func toggleFavorite(id: UUID) {
        if let index = favoriteList.firstIndex(where: { $0.id == id }) {
            favoriteList[index].isFavorite.toggle()
            print("즐겨찾기 토글: \(favoriteList[index].certificationName)")
        }
    }
    
    func updateJobCategories(_ categories: [JobCategory]) async {
        self.jobCategoryList = categories

        let request: JobEntity = JobEntity(jobs: jobCategoryList.map{ $0.description })
        let result = await editJobUseCase.execute(jobNameList: request)
        
        switch result {
        case .success:
            logger.debug("✅ updateJobCategories success")
        case .failure(let error):
            logger.error("❌ updateJobCategories failed: \(error.localizedDescription)")
        }
    }
    
    func getUnivList(keyword: String) async {
        let result = await fetchUnivListUseCase.execute(keyword: keyword)
        
        switch result {
        case .success(let data):
            self.universityList = data.universityNameList
            logger.debug("✅ getUnivList success: \(data.universityNameList)")
        case .failure(let error):
            logger.error("getUnivList failed: \(error.localizedDescription)")
        }
    }
    
    func editUniv(univ: String) async {
        let result = await editUnivUseCase.execute(request: univ)
        
        switch result {
        case .success:
            logger.debug("✅ editUniv success")
        case .failure(let error):
            logger.error("editUniv failed: \(error.localizedDescription)")
        }
    }
    
    func getMajorList(keyword: String) async {
        let result = await fetchMajorListUseCase.execute(keyword: keyword)
        
        switch result {
        case .success(let data):
            self.majorList = data.majorNameList
            logger.debug("✅ getMajorList success: \(data.majorNameList)")
        case .failure(let error):
            logger.error("getMajorList failed: \(error.localizedDescription)")
        }
    }
    
    func editMajor(major: String) async {
        let result = await editMajorUseCase.execute(request: major)
        
        switch result {
        case .success:
            logger.debug("✅ editMajor success")
        case .failure(let error):
            logger.error("editMajor failed: \(error.localizedDescription)")
        }
    }
    
}


// MARK: - Navigation Func

extension MyPageViewModel {
    
    func navigateToEditProfile() {
        myPageViewRoute = .navigateToEditProfile
    }
    
    func navigateToManageAcademicInfo() {
        myPageViewRoute = .navigateToManageAcademicInfo
    }
    
    func navigateToEditUniversity() {
        myPageViewRoute = .navigateToEditUniversity
    }
    
    func navigateToEditMajor() {
        myPageViewRoute = .navigateToEditMajor
    }
    
    func navigateToManageCertificates() {
        myPageViewRoute = .navigateToManageCertificates
    }
    
    func navigateToSettings() {
        myPageViewRoute = .navigateToSettings
    }
    
    func navigateToNotificationSettings() {
        myPageViewRoute = .navigateToNotificationSettings
    }
    
    func navigateToEditExpectedCertificate() {
        myPageViewRoute = .navigateToEditExpectedCertificate
    }
    
    func navigateToEditCompletedCertificate() {
        myPageViewRoute = .navigateToEditCompletedCertificate
    }
    
    func myPageViewRoutePop() {
        myPageViewRoute = .myPageViewRoutePop
    }
}


// MARK: - Private Func

extension MyPageViewModel {
    private func convertToMyPageInfo(entity: MyPageEntity) {
        self.userNickName = entity.nickname
        self.profileImageURL = entity.profileImageURL
        self.userEmail = entity.email
        self.jobCategoryList = entity.jobResponse.jobs.compactMap { JobCategory(rawValue: $0) }
        self.upCertificationCount = entity.upCount
        self.acCertificationCount = entity.acCount
        self.fCertificationCount = entity.fCount
    }
    
    private func convertToEditProfileInfo(entity: EditProfileEntity) {
        self.userNickName = entity.nickName
        self.userName = entity.name
        self.profileImageURL = entity.profileImageURL
        self.userEmail = entity.email
        self.userBirth = entity.birthDate?.convertToDate()
        self.initialProfile = ProfileSnapshot(
            nickName: entity.nickName,
            name: entity.name,
            email: entity.email,
            birth: self.userBirth,
            profileImageURL: entity.profileImageURL
        )
    }
    
    private func convertToEditProfileEntity() -> EditProfileEntity {
        return EditProfileEntity(
            nickName: userNickName,
            name: userName,
            email: userEmail,
            birthDate: userBirth?.toServerFormatString(),
            profileImageURL: profileImageURL
        )
    }
    
    private func loadDummyData() {
        expectedList = [
            ExpectedItem(certificationName: "정보처리기사", agencyName: "국가기술자격", averagePeriod: "3개월", description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...", city: "고양시", state: "일산동구", formattedTime: "09:00"),
            ExpectedItem(certificationName: "SQLD", agencyName: "데이터자격", averagePeriod: "1개월", description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...", city: "서울시", state: "강남구", formattedTime: "13:00"),
            ExpectedItem(certificationName: "ADsP", agencyName: "데이터자격", averagePeriod: "2주", description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...", city: "성남시", state: "분당구", formattedTime: "10:00")
        ]
        
        completedList = [
            CompletedItem(name: "정보처리기사", categoryText: "국가기술자격", description: "소프트웨어 개발 관련 자격증으로, 계획수립, 분석, 설계, 구현...", formattedDate: "2025. 11. 23", grade: "합격"),
            CompletedItem(name: "OPIC", categoryText: "어학", description: "영어 말하기 시험", formattedDate: "2025. 10. 10", grade: "IM3"),
            CompletedItem(name: "한국사능력검정", categoryText: "국가자격", description: "한국사 능력을 평가하는 시험", formattedDate: "2024. 08. 15", grade: "1급")
        ]
        
        favoriteList = [
            FavoriteItem(certificationName: "정보보안기사", certificationType: "국가기술자격", testType: "필기형", agencyName: "KISA", isFavorite: true),
            FavoriteItem(certificationName: "AWS SAA", certificationType: "해외자격", testType: "CBT", agencyName: "Amazon", isFavorite: true),
            FavoriteItem(certificationName: "컴퓨터활용능력 1급", certificationType: "국가기술자격", testType: "실기형", agencyName: "대한상공회의소", isFavorite: true)
        ]
    }
}


// MARK: - UI 구현용 임시 아이템 모델들

struct ExpectedItem: Identifiable {
    let id = UUID()
    let certificationName: String // 자격증 이름
    let agencyName: String        // 주관사 (카테고리 대용)
    let averagePeriod: String     // 준비 기간
    let description: String       // 설명
    let city: String              // 장소 (시)
    let state: String             // 장소 (구)
    let formattedTime: String     // 시간
}

struct CompletedItem: Identifiable {
    let id = UUID()
    let name: String              // 자격증 이름
    let categoryText: String      // 카테고리
    let description: String       // 설명
    let formattedDate: String     // 취득 날짜
    let grade: String?            // 점수/등급
}

struct FavoriteItem: Identifiable {
    let id = UUID()
    let certificationName: String // 자격증 이름
    let certificationType: String // 자격증 타입 (국가기술자격 등)
    let testType: String          // 시험 타입 (실기/필기)
    let agencyName: String        // 주관사
    var isFavorite: Bool          // 즐겨찾기 여부
}
