//
//  HomeViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import os

enum HomeViewRoute {
    case withDraw
    case navigateToPreLicenseEdit
    case navigateToCertificateDetail
    case navigateToCertificateTab
    
    case homeViewRoutePop
}

// 뷰모델 사용 예시를 보여주기 위한 임시 모델
struct HomeStateModel {
    var username: String = ""
    var userUniversity: String = ""
    var userDepartment: String = ""
    var progressValue: Int = 0
    
    var recommendLicenses: [RecommendLicenseCardModel] = []
    var preLicenses: [PreLicenseCardModel] = []
    var favoriteLicenses: [FavoriteLicenseCardModel] = []
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var homeStateModel = HomeStateModel()
    @Published var selectedLicenseId: Int = 0
    @Published var homeViewRoute: HomeViewRoute?
    @Published var currentDate: Date = .distantPast
    @Published var currentMonth: Int = 0
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CETRI", category: "HOME")
    
    private let deletePreCertificationUseCase: DeletePreCertificationUseCase
    private let getPreCertificationsUseCase: GetPreCertificationUseCase
    private let getFavoriteCertificationsUseCase: GetFavoriteCertificationUseCase
    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    private let withDrawUseCase: WithDrawUseCase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let fetchRecommendUseCase: FetchRecommendUseCase
    
    init(
        deletePreCertificationUseCase: DeletePreCertificationUseCase,
        getPreCertificationsUseCase: GetPreCertificationUseCase,
        getFavoriteCertificationsUseCase: GetFavoriteCertificationUseCase,
        fetchUserInfoUseCase: FetchUserInfoUseCase,
        withDrawUseCase: WithDrawUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchRecommendUseCase: FetchRecommendUseCase
    ) {
        self.deletePreCertificationUseCase = deletePreCertificationUseCase
        self.getPreCertificationsUseCase = getPreCertificationsUseCase
        self.getFavoriteCertificationsUseCase = getFavoriteCertificationsUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.withDrawUseCase = withDrawUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchRecommendUseCase = fetchRecommendUseCase
    }

}


// MARK: - Navigation Func

extension HomeViewModel {
    
    func withDrawNavigate() {
        homeViewRoute = .withDraw
    }
    
    func navigateToPreLicenseEdit() {
        homeViewRoute = .navigateToPreLicenseEdit
    }

    func navigateToCertificateDetail() {
        homeViewRoute = .navigateToCertificateDetail
    }
    
    func navigateToCertificateTab() {
        homeViewRoute = .navigateToCertificateTab
    }
    
    func homeViewRoutePop() {
        homeViewRoute = .homeViewRoutePop
    }
}


// MARK: - Network

extension HomeViewModel {
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
    
    func getUserInfo() async {
        let result = await fetchUserInfoUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 유저 정보 조회 성공")
            homeStateModel = response.toHomeStateModel()
            AuthManager.shared.nickname = response.nickname
            AuthManager.shared.name = response.name
            AuthManager.shared.userID = response.userId
            
        case .failure(let error):
            logger.error("❌ 유저 정보 조회: \(error.localizedDescription)")
        }
    }
    
    func getRecommendCertificationList() async {
        let result = await fetchRecommendUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 추천 자격증 조회 성공")
            
            let list = response.toRecommendLicenseCardModelList()
            homeStateModel.recommendLicenses = list
            
        case .failure(let error):
            logger.error("❌ 추천 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchPreCertification() async {
        let result = await getPreCertificationsUseCase.execute()
        
        switch result {
        case .success(let models):
            logger.info("✅ 취득 예정 자격증 조회 성공")

            self.homeStateModel.preLicenses = models.toPreLicenseCardModelList()
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func deletePreCertification(id: Int) async {
        let result = await deletePreCertificationUseCase.execute(id: id)
        
        switch result {
        case .success:
            logger.info("✅ 취득 예정 자격증 삭제 성공")
            homeStateModel.preLicenses.removeAll { $0.certificationId == id }
            
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 삭제 실패: \(error.localizedDescription)")
            
        }
    }
    
    func getFavoriteCertificationList() async {
        let result = await getFavoriteCertificationsUseCase.execute()
                
        switch result {
        case .success(let response):
            logger.info("✅ 즐겨찾기 자격증 조회 성공")
            
            let list = response.toFavoriteLicenseCardModelList()
            homeStateModel.favoriteLicenses = list
            
        case .failure(let error):
            logger.error("❌ 취득 예정 자격증 삭제 실패: \(error.localizedDescription)")
            
        }
    }
    
    func toggleFavoriteCertification(certificationId: Int) async {
        let result = await switchFavoriteUseCase.execute(id: certificationId)
        
        switch result {
        case .success():
            logger.debug("✅ toggleFavorite success")

        case .failure(let error):
            logger.error("toggleFavorite failed: \(error.localizedDescription)")

        }
    }
    
}


// MARK: - Func

extension HomeViewModel {
    func toggleFavorite(id: Int) {
        guard let index = homeStateModel.favoriteLicenses.firstIndex(where: { $0.certificationId == id }) else { return }
        homeStateModel.favoriteLicenses[index].isFavorite.toggle()
    }
    
    func getYearAndMonthString(currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        formatter.locale = Locale(identifier: "ko_kr")
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDate() -> [DateValueModel] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        let currentMonthDays = currentMonth.getAllDates().compactMap { date -> DateValueModel in
            let day = calendar.component(.day, from: date)
            return DateValueModel(day: day, date: date, isCurrentMonth: true)
        }
        
        var days = currentMonthDays
        
        let firstWeekday = calendar.component(.weekday, from: currentMonthDays.first!.date)
        
        if let prevMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            let prevMonthDays = prevMonth.getAllDates()
            let prefixDays = prevMonthDays.suffix(firstWeekday - 1)
            
            let prevMonthValues = prefixDays.map { date in
                DateValueModel(day: calendar.component(.day, from: date), date: date, isCurrentMonth: false)
            }
            days.insert(contentsOf: prevMonthValues, at: 0)
        }
        
        return days
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // 현재 달 가져오기
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func isSameDay(day1: Date, day2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(day1, inSameDayAs: day2)
    }
    
    func dayState(for value: DateValueModel) -> CalendarDayState {
        if !value.isCurrentMonth {
            return .otherMonth
        }
        
        let isToday = Calendar.current.isDate(value.date, inSameDayAs: Date())
        let isSelected = currentDate != .distantPast && Calendar.current.isDate(value.date, inSameDayAs:currentDate)
        
        switch (isToday, isSelected) {
        case (true, true):
            return .todaySelected
        case (true, false):
            return .today
        case (false, true):
            return .selected
        default:
            return .normal
        }
    }
    
    func hasPreLicenses(on date: Date) -> Bool {
        // 추후 api 연동
        return false
    }
}
