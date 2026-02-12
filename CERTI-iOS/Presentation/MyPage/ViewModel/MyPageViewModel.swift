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
    case withDraw
    case logout
    case navigateToCertificateDetail

    
    case myPageViewRoutePop
}

@MainActor
final class MyPageViewModel: ObservableObject {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "MyPage")
    
    //MARK: - Property Wrappers
    
    @Published var myPageViewRoute: MyPageViewRoute?
    @Published var userName: String = ""
    @Published var userNickName: String = "" {
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
    @Published var marketingAgreeState: Bool = false
    @Published var privacyAgreeState: Bool = false
    
    @Published var selectedLicenseId: Int = 0

    
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
    private let getPreCertificationsUseCase: GetPreCertificationUseCase
    private let getFavoriteCertificationsUseCase: GetFavoriteCertificationUseCase
    private let withDrawUseCase: WithDrawUseCase
    private let getNotificationSettingUseCase: GetNotificationSettingUseCase
    private let toggleMarketingSettingUseCase: ToggleMarketingSettingUseCase
    private let togglePrivacySettingUseCase: TogglePrivacySettingUseCase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    private let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    private let deletePreCertificationUseCase: DeletePreCertificationUseCase

    
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
        editUnivUseCase: EditUnivUseCase,
        getPreCertificationsUseCase: GetPreCertificationUseCase,
        getFavoriteCertificationsUseCase: GetFavoriteCertificationUseCase,
        withDrawUseCase: WithDrawUseCase,
        getNotificationSettingUseCase: GetNotificationSettingUseCase,
        toggleMarketingSettingUseCase: ToggleMarketingSettingUseCase,
        togglePrivacySettingUseCase: TogglePrivacySettingUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        deleteAcquisitionUseCase: DeleteAcquisitionUseCase,
        deletePreCertificationUseCase: DeletePreCertificationUseCase,
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
        self.getPreCertificationsUseCase = getPreCertificationsUseCase
        self.getFavoriteCertificationsUseCase = getFavoriteCertificationsUseCase
        self.withDrawUseCase = withDrawUseCase
        self.getNotificationSettingUseCase = getNotificationSettingUseCase
        self.toggleMarketingSettingUseCase = toggleMarketingSettingUseCase
        self.togglePrivacySettingUseCase = togglePrivacySettingUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.deleteAcquisitionUseCase = deleteAcquisitionUseCase
        self.deletePreCertificationUseCase = deletePreCertificationUseCase
    }
    
}


// MARK: - Func

extension MyPageViewModel {
    func withDraw() async {
        let result = await withDrawUseCase.execute()

        switch result {
        case .success:
            logger.info("✅ 탈퇴 성공")
            AuthManager.shared.cleanUserInfo()
            
        case .failure(let error):
            logger.error("❌ 탈퇴 실패: \(error.localizedDescription)")
        }
    }
    
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
    
    func fetchCompletedCertificate() async {
        let result = await fetchAcquisitionListUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ fetchCompletedCertificate success")
            let list: [CompletedItem] = response.acquisitionList.map {
                CompletedItem(
                    id: $0.certificationID,
                    aquisionID: $0.acquisitionID,
                    name: $0.name,
                    categoryText: $0.certificationType,
                    description: $0.description,
                    formattedDate: $0.acquisitionDate,
                    grade: $0.grade
                )
            }
            completedList = list
            
        case .failure(let error):
            logger.error("❌ fetchCompletedCertificate failed: \(error.localizedDescription)")
        }
    }
    
    func deleteCompletedCertificate(id: Int) async {
        let result = await deleteAcquisitionUseCase.execute(id: id)
        
        switch result {
        case .success:
            logger.debug("✅ deleteCompletedCertificate success")
            completedList.removeAll { $0.aquisionID == id }

        case .failure(let error):
            logger.error("❌ deleteCompletedCertificate failed: \(error.localizedDescription)")
        }
    }
    
    func fetchExpectedCertificate() async {
        let result = await getPreCertificationsUseCase.execute()
        
        switch result {
        case .success(let response):
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            inputFormatter.locale = Locale(identifier: "en_US_POSIX")
            inputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            outputFormatter.locale = Locale(identifier: "ko_KR")
            
            let newItems: [ExpectedItem] = response.certifications.map { cert in
                var finalTimeStr = cert.testDate
                
                if let date = inputFormatter.date(from: cert.testDate) {
                    finalTimeStr = outputFormatter.string(from: date)
                }
                
                return ExpectedItem(
                    id: cert.certificationID,
                    certificationName: cert.certificationName,
                    agencyName: cert.agencyName,
                    averagePeriod: cert.averagePeriod,
                    description: cert.description,
                    city: cert.city,
                    state: cert.state,
                    formattedTime: finalTimeStr
                )
            }
            self.expectedList = newItems
            
        case .failure(let error):
            logger.error("❌ updateJobCategories failed: \(error.localizedDescription)")
        }
    }
    
    // TODO: - 등록 API 연결 후 연결
    func deleteExpectedCertificate(id: Int) async {
        let result = await deletePreCertificationUseCase.execute(id: id)
        
        switch result {
        case .success:
            logger.debug("✅ deleteExpectedCertificate success")
            expectedList.removeAll { $0.id == id }

        case .failure(let error):
            logger.error("❌ deleteExpectedCertificate failed: \(error.localizedDescription)")
        }
    }
    
    // TODO: - 등록 API 연결 후 연결
    func editCertificate(id: Int) {
        print("수정 요청: \(id)")
    }
    
    func getFavoriteCertificates() async {
        let result = await getFavoriteCertificationsUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ getFavoriteCertificates success")
            let list: [FavoriteItem] = response.certifications.compactMap{
                FavoriteItem(
                    id: $0.certificationId,
                    certificationName: $0.certificationName,
                    certificationType: $0.certificationType,
                    testType: $0.testType,
                    agencyName: $0.agencyName,
                    isFavorite: $0.isFavorite
                )
            }

            favoriteList = list
        case .failure(let error):
            logger.error("❌ getFavoriteCertificates failed: \(error.localizedDescription)")
        }
    }
    
    func toggleFavorite(id: Int) async {
        let result = await switchFavoriteUseCase.execute(id: id)
        
        switch result {
        case .success:
            logger.debug("✅ toggleFavorite success")
            if let index = favoriteList.firstIndex(where: { $0.id == id }) {
                favoriteList[index].isFavorite.toggle()
            }
        case .failure(let error):
            logger.error("❌ getFavoriteCertificates failed: \(error.localizedDescription)")
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
    
    func getNotificationSetting() async {
        let result = await getNotificationSettingUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.debug("✅ getNotificationSetting success")
            self.marketingAgreeState = response.isAdAgreed
            self.privacyAgreeState = response.isPvAgreed
        case .failure(let error):
            logger.error("getNotificationSetting failed: \(error.localizedDescription)")
        }
    }
    
    func toggleMarketingSetting() async {
        let result = await toggleMarketingSettingUseCase.execute(agree: !marketingAgreeState)
        
        switch result {
        case .success:
            logger.debug("✅ toggleMarketingSetting success")
            marketingAgreeState.toggle()
        case .failure(let error):
            logger.error("toggleMarketingSetting failed: \(error.localizedDescription)")
        }
    }
    
    func togglePrivacySetting() async {
        let result = await togglePrivacySettingUseCase.execute(agree: !privacyAgreeState)
        
        switch result {
        case .success:
            logger.debug("✅ togglePrivacySetting success")
            privacyAgreeState.toggle()
        case .failure(let error):
            logger.error("togglePrivacySetting failed: \(error.localizedDescription)")
        }
    }
    
}


// MARK: - Navigation Func

extension MyPageViewModel {
    func logoutNavigate() {
        myPageViewRoute = .logout
    }
    
    func withDrawNavigate() {
        myPageViewRoute = .withDraw
    }
    
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
    
    func navigateToCertificateDetail() {
        myPageViewRoute = .navigateToCertificateDetail
    }
}


// MARK: - Private Func

extension MyPageViewModel {
    private func convertToMyPageInfo(entity: MyPageEntity) {
        self.userNickName = entity.nickname
        self.profileImageURL = entity.profileImageURL ?? ""
        self.userEmail = entity.email
        self.jobCategoryList = entity.jobResponse.jobs.compactMap { JobCategory(rawValue: $0) }
        self.upCertificationCount = entity.upCount
        self.acCertificationCount = entity.acCount
        self.fCertificationCount = entity.fCount
    }
    
    private func convertToEditProfileInfo(entity: EditProfileEntity) {
        self.userNickName = entity.nickName
        self.userName = entity.name
        self.profileImageURL = entity.profileImageURL ?? ""
        self.userEmail = entity.email
        self.userBirth = entity.birthDate?.convertToDate()
        self.initialProfile = ProfileSnapshot(
            nickName: entity.nickName,
            name: entity.name,
            email: entity.email,
            birth: self.userBirth,
            profileImageURL: entity.profileImageURL ?? ""
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
}
