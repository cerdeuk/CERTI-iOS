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
    
    func makeLoginUseCase() -> LoginUseCase {
        return DefaultLoginUseCase(repository: authRepository)
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
            fetchUnivListUseCase: makeFetchUnivListUseCase()
        )
    }
    
    func makeRecommendFactory() -> RecommendFactory {
        return DefaultRecommendFactory(
            fetchRecommendUseCase: makeFetchRecommendUseCase(),
            switchFavoriteUseCase: makeSwitchFavoriteUseCase(),
            fetchJobUseCase: makeFetchJobUseCase(),
            editJobUseCase: makeEditJobUseCase()
        )
    }
    
    func makeCategoryFactory() -> CategoryFactory {
        return DefaultCategoryFactory(
            fetchCategoryUseCase: makeFetchCategoryUseCase(),
            switchFavoriteUseCase: makeSwitchFavoriteUseCase(),
            searchCertificationUseCase: makeSearchCertificationUseCase()
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
}
