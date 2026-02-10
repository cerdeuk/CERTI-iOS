//
//  AppDIContainer.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//

import Foundation

final class AppDIContainer {
    
    static let shared = AppDIContainer()
    
    private init() { }

    /// TODO: - 매번 API 연결할 때마다 service랑 repository에 case 만들고 usecase 만들고 DIContainer에서 생성해서 일일이 의존성 주입해주려니 너무 귀찮음;;
    /// 여유될 때 방법을 좀 모색해보자
    
    // MARK: - Services
    
    private lazy var homeService: HomeServiceProtocol = HomeService()
    private lazy var authService: AuthServiceProtocol = AuthService()
    private lazy var onboardingService: OnboardingServiceProtocol = OnboardingService()
    private lazy var certificationService: CertificationServiceProtocol = CertificationService()
    private lazy var jobService: JobsServiceProtocol = JobService()
    private lazy var userService: UserServiceProtocol = UserService()
    private lazy var acquisitionService: AcquisitionServiceProtocol = AcquisitionService()
    private lazy var careersService: CareersServiceProtocol = CareersService()
    private lazy var activityService: ActivityServiceProtocol = ActivityService()
    /*private*/ lazy var tokenRefreshService: TokenRefreshServiceProtocol = TokenRefreshService()
    
    
    // MARK: - Repositories
    // UseCase 다 만들면 private 붙이기
    
    private lazy var homeRepository: HomeRepository = DefaultHomeRepository(service: homeService)
    private lazy var authRepository: AuthRepository = DefaultAuthRepository(service: authService)
    private lazy var onboardingRepository: OnboardingRepository = DefaultOnboardingRepository(service: onboardingService)
    private lazy var certificationRepository: CertificationRepository = DefaultCertificationRepository(service: certificationService)
    private lazy var jobRepository: JobRepository = DefaultJobRepository(service: jobService)
    private lazy var userRepository: UserRepository = DefaultUserRepository(service: userService)
    private lazy var acquisitionRepository: AcquisitionRepository = DefaultAcquisitionRepository(service: acquisitionService)
    private lazy var careersRepository: CareersRepository = DefaultCareersRepository(service: careersService)
    private lazy var activityRepository: ActivityRepository = DefaultActivityRepository(service: activityService)
    
}


// MARK: - UseCase

extension AppDIContainer {
    
    func makeAddPreCertificationUseCase() -> AddPreCertificationUseCase {
        return DefaultAddPreCertificationUseCase(repository: homeRepository)
    }
    
    func makeDeletePreCertificationUseCase() -> DeletePreCertificationUseCase {
        return DefaultDeletePreCertificationUseCase(repository: homeRepository)
    }
    
    func makeGetPreCertificationUseCase() -> GetPreCertificationUseCase {
        return DefaultGetPreCertificationUseCase(repository: homeRepository)
    }
    
    func makeGetFavoritePreCertificationUseCase() -> GetFavoriteCertificationUseCase {
        return DefaultGetFavoriteCertificationUseCase(repository: homeRepository)
    }

    func makeFetchUserInfoUseCase() -> FetchUserInfoUseCase {
        return DefaultFetchUserInfoUseCase(repository: userRepository)
    }
    
    
    // MARK: - AuthUseCase
    
    func makeKakaoLoginUseCase() -> KakaoLoginUseCase {
        return DefaultKakaoLoginUseCase(repository: authRepository)
    }
    
    func makeSignUpUseCase() -> SignUpUseCase {
        return DefaultSignUpUseCase(repository: authRepository)
    }
    
    func makeWithDrawUseCase() -> WithDrawUseCase {
        return DefaultWithDrawUseCase(repository: authRepository)
    }
    
    func makeFetchUnivListUseCase() -> FetchUnivListUseCase {
        return DefaultFetchUnivListUseCase(repository: onboardingRepository)
    }
    
    func makeFetchMajorListUseCase() -> FetchMajorListUseCase {
        return DefaultFetchMajorListUseCase(repository: onboardingRepository)
    }
    
    func makeFetchJobUseCase() -> FetchJobUseCase {
        return DefaultFetchJobUseCase(repository: jobRepository)
    }
    
    func makeEditJobUseCase() -> EditJobUseCase {
        return DefaultEditJobUseCase(repository: jobRepository)
    }
  
    func makeFetchCategoryUseCase() -> FetchCategoryUseCase {
        return DefaultFetchCategoryUseCase(repository: certificationRepository)
    }
    
    func makeSwitchFavoriteUseCase() -> SwitchFavoriteUseCase {
        return DefaultSwitchFavoriteUseCase(repository: certificationRepository)
    }
    
    func makeSearchCertificationUseCase() -> SearchCertificationUseCase {
        return DefaultSearchCertificationUseCase(repository: certificationRepository)
    }
    
    func makeFetchCertificationDetailUseCase() -> FetchCertificationDetailUseCase {
        return DefaultFetchCertificationDetailUseCase(repository: certificationRepository)
    }
    
    func makeFetchRecommendUseCase() -> FetchRecommendUseCase {
        return DefaultFetchRecommendUseCase(repository: certificationRepository)
    }
  
    func makeFetchAcquisitionListUseCase() -> FetchAcquisitionListUseCase {
        return DefaultFetchAcquisitionListUseCase(repository: acquisitionRepository)
    }
    
    func makeFetchAcquisitionDetailUseCase() -> FetchAcquisitionDetailUseCase {
        return DefaultFetchAcquisitionDetailUseCase(repository: acquisitionRepository)
    }
    
    func makeAddAcquisitionUseCase() -> AddAcquisitionUseCase {
        return DefaultAddAcquisitionUseCase(repository: acquisitionRepository)
    }
    
    func makeDeleteAcquisitionUseCase() -> DeleteAcquisitionUseCase {
        return DefaultDeleteAcquisitionUseCase(repository: acquisitionRepository)
    }
    
    func makeAddCareersUseCase() -> AddCareersUseCase {
        return DefaultAddCareersUseCase(repository: careersRepository)
    }
    
    func makeDeleteCareersUseCase() -> DeleteCareersUseCase {
        return DefaultDeleteCareersUseCase(repository: careersRepository)
    }
    
    func makeFetchCareersListUseCase() -> FetchCareersListUseCase {
        return DefaultFetchCareersListUseCase(repository: careersRepository)
    }
    
    func makeAddActivityUseCase() -> AddActivityUseCase {
        return DefaultAddActivityUseCase(repository: activityRepository)
    }
    
    func makeDeleteActivityUseCase() -> DeleteActivityUseCase {
        return DefaultDeleteActivityUseCase(repository: activityRepository)
    }
    
    func makeFetchActivityListUseCase() -> FetchActivityListUseCase {
        return DefaultFetchActivityListUseCase(repository: activityRepository)
    }
    
    func makeCheckNickNameUseCase() -> CheckNickNameUseCase {
        return DefaultCheckNickNameUseCase(repository: userRepository)
    }
    
    func makeFetchMyPageInfoUseCase() -> FetchMyPageInfoUseCase {
        return DefaultFetchMyPageInfoUseCase(repository: userRepository)
    }
    
    func makeFetchEditProfileInfoUseCase() -> FetchEditProfileInfoUseCase {
        return DefaultFetchEditProfileInfoUseCase(repository: userRepository)
    }
    
    func makeUpdateEditProfileInfoUseCase() -> UpdateEditProfileInfoUseCase {
        return DefaultUpdateEditProfileInfoUseCase(repository: userRepository)
    }
    
    func makeFetchMyPageUnivListUseCase() -> FetchMyPageUnivListUseCase {
        return DefaultFetchMyPageUnivListUseCase(repository: userRepository)
    }
    
    func makeFetchMyPageMajorListUseCase() -> FetchMyPageMajorListUseCase {
        return DefaultFetchMyPageMajorListUseCase(repository: userRepository)
    }
    
    func makeEditMajorUseCase() -> DefaultEditMajorUseCase {
        return DefaultEditMajorUseCase(repository: userRepository)
    }
    
    func makeEditUnivUseCase() -> DefaultEditUnivUseCase {
        return DefaultEditUnivUseCase(repository: userRepository)
    }
    
    func makeToggleNotificationSettingUseCase() -> DefaultToggleNotificationSettingUseCase {
        return DefaultToggleNotificationSettingUseCase(repository: userRepository)
    }
    
    func makeGetNotificationSettingUseCase() -> DefaultGetNotificationSettingUseCase {
        return DefaultGetNotificationSettingUseCase(repository: userRepository)
    }
    
    func makeGetTrackRankCertificationUsecase() -> DefaultGetTrackRankCertificationUsecase {
        return DefaultGetTrackRankCertificationUsecase(repository: certificationRepository)
    }
    
    func makeGetJobRankCertificationUsecase() -> DefaultGetJobRankCertificationUsecase {
        return DefaultGetJobRankCertificationUsecase(repository: certificationRepository)
    }
    
    func makeGetTrackCertificationListUsecase() -> DefaultGetTrackCertificationListUsecase {
        return DefaultGetTrackCertificationListUsecase(repository: certificationRepository)
    }
    
    func makeGetJobCertificationListUsecase() -> DefaultGetJobCertificationListUsecase {
        return DefaultGetJobCertificationListUsecase(repository: certificationRepository)
    }
    
    func makeFetchTrackUsecase() -> DefaultFetchTrackUsecase {
        return DefaultFetchTrackUsecase(repository: userRepository)
    }
}


// MARK: - Factories

extension AppDIContainer {
    
    func makeHomeFactory() -> HomeFactory {
        return DefaultHomeFactory(
            deletePreUseCase: makeDeletePreCertificationUseCase(),
            getPreUseCase: makeGetPreCertificationUseCase(),
            getFavoriteUseCase: makeGetFavoritePreCertificationUseCase(),
            fetchUserInfoUseCase: makeFetchUserInfoUseCase(),
            withDrawUseCase: makeWithDrawUseCase(),
            switchFavoriteUseCase: makeSwitchFavoriteUseCase(),
            fetchRecommendUseCase: makeFetchRecommendUseCase()
        )
    }
    
    func makeOnboardingFactory() -> OnboardingFactory {
        return DefaultOnboardingFactory(
            fetchMajorListUseCase: makeFetchMajorListUseCase(),
            fetchUnivListUseCase: makeFetchUnivListUseCase(),
            signupUseCase: makeSignUpUseCase(),
            checkNickNameUseCase: makeCheckNickNameUseCase()
        )
    }

    func makeCertificateDetailFactory() -> CertificateDetailFactory {
        return DefaultCertificationDetailFactory(
          fetchCertificationDetailUseCase: makeFetchCertificationDetailUseCase(),
          addPreCertificationUseCase: makeAddPreCertificationUseCase(),
          addAcquisitionUseCase: makeAddAcquisitionUseCase()
        )
    }
  
    func makeResumeFactory() -> ResumeFactory {
        return DefaultResumeFactory(
            fetchJobUseCase: makeFetchJobUseCase(),
            fetchAcquisitionListUseCase: makeFetchAcquisitionListUseCase(),
            fetchAcquisitionDetailUseCase: makeFetchAcquisitionDetailUseCase(),
            deleteAcquisitionUseCase: makeDeleteAcquisitionUseCase(),
            addCareersUseCase: makeAddCareersUseCase(),
            deleteCareersUseCase: makeDeleteCareersUseCase(),
            fetchCareersListUseCase: makeFetchCareersListUseCase(),
            addActivityUseCase: makeAddActivityUseCase(),
            deleteActivityUseCase: makeDeleteActivityUseCase(),
            fetchActivityListUseCase: makeFetchActivityListUseCase()
        )
    }
    
    func makeMyPageFactory() -> MyPageFactory {
        return DefaultMyPageFactory(
            fetchMyPageInfoUseCase: makeFetchMyPageInfoUseCase(),
            fetchEditProfileInfoUseCase: makeFetchEditProfileInfoUseCase(),
            checkNickNameUseCase: makeCheckNickNameUseCase(),
            updateEditProfileInfoUseCase: makeUpdateEditProfileInfoUseCase(),
            editJobUseCase: makeEditJobUseCase(),
            fetchMajorListUseCase: makeFetchMyPageMajorListUseCase(),
            fetchUnivListUseCase: makeFetchMyPageUnivListUseCase(),
            editMajorUseCase: makeEditMajorUseCase(),
            editUnivUseCase: makeEditUnivUseCase(),
            getPreCertificationUseCase: makeGetPreCertificationUseCase(),
            getFavoriteCertificationUseCase: makeGetFavoritePreCertificationUseCase(),
            withDrawUseCase: makeWithDrawUseCase(),
            getNotificationSettingUseCase: makeGetNotificationSettingUseCase(),
            toggleNotificationSettingUseCase: makeToggleNotificationSettingUseCase(),
            switchFavoriteUseCase: makeSwitchFavoriteUseCase(),
            fetchAcquisitionListUseCase: makeFetchAcquisitionListUseCase()
        )
    }
    
    func makeLoginFactory() -> LoginFactory {
        return DefaultLoginFactory(kakoLoginUseCase: makeKakaoLoginUseCase())
    }
    
    func makeCertificateFactory() -> CertificateFactory {
        return DefaultCertificateFactory(
            fetchRecommendUseCase: makeFetchRecommendUseCase(),
            getTrackRankCertificationUsecase: makeGetTrackRankCertificationUsecase(),
            getJobRankCertificationUsecase: makeGetJobRankCertificationUsecase(),
            getJobCertificationListUsecase: makeGetJobCertificationListUsecase(),
            getTrackCertificationListUsecase: makeGetTrackCertificationListUsecase(),
            fetchJobUseCase: makeFetchJobUseCase(),
            fetchTrackUsecase: makeFetchTrackUsecase(),
            switchFavoriteUseCase: makeSwitchFavoriteUseCase(),
            searchCertificationUseCase: makeSearchCertificationUseCase()
        )
    }
}
