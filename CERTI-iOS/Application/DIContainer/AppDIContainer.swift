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
    
    /*private*/ lazy var homeRepository: HomeRepository = DefaultHomeRepository(service: homeService)
    /*private*/ lazy var authRepository: AuthRepository = DefaultAuthRepository(service: authService)
    /*private*/ lazy var onboardingRepository: OnboardingRepository = DefaultOnboardingRepository(service: onboardingService)
    /*private*/ lazy var certificationRepository: CertificationRepository = DefaultCertificationRepository(service: certificationService)
    /*private*/ lazy var jobRepository: JobRepository = DefaultJobRepository(service: jobService)
    /*private*/ lazy var userRepository: UserRepository = DefaultUserRepository(service: userService)
    /*private*/ lazy var acquisitionRepository: AcquisitionRepository = DefaultAcquisitionRepository(service: acquisitionService)
    /*private*/ lazy var careersRepository: CareersRepository = DefaultCareersRepository(service: careersService)
    /*private*/ lazy var activityRepository: ActivityRepository = DefaultActivityRepository(service: activityService)
    
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
    private var acquisitionRepositoryInstance: AcquisitionRepository {
        return DefaultAcquisitionRepository(service: makeAcquisitionService())
    }
    
    private var careersRepositoryInstance: CareersRepository {
        return DefaultCareersRepository(service: makeCareersService())
    }
    
    private var activityRepositoryInstance: ActivityRepository {
        return DefaultActivityRepository(service: makeActivityService())
    }
    
    func makeAddPreCertificationUseCase() -> AddPreCertificationUseCase {
        return DefaultAddPreCertificationUseCase(repository: homeRepositoryInstance)
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
    
    func makeFetchAcquisitionListUseCase() -> FetchAcquisitionListUseCase {
        return DefaultFetchAcquisitionListUseCase(repository: acquisitionRepositoryInstance)
    }
    
    func makeFetchAcquisitionDetailUseCase() -> FetchAcquisitionDetailUseCase {
        return DefaultFetchAcquisitionDetailUseCase(repository: acquisitionRepositoryInstance)
    }
    
    func makeAddAcquisitionUseCase() -> AddAcquisitionUseCase {
        return DefaultAddAcquisitionUseCase(repository: acquisitionRepositoryInstance)
    }
    
    func makeDeleteAcquisitionUseCase() -> DeleteAcquisitionUseCase {
        return DefaultDeleteAcquisitionUseCase(repository: acquisitionRepositoryInstance)
    }
    
    func makeAddCareersUseCase() -> AddCareersUseCase {
        return DefaultAddCareersUseCase(repository: careersRepositoryInstance)
    }
    
    func makeDeleteCareersUseCase() -> DeleteCareersUseCase {
        return DefaultDeleteCareersUseCase(repository: careersRepositoryInstance)
    }
    
    func makeFetchCareersListUseCase() -> FetchCareersListUseCase {
        return DefaultFetchCareersListUseCase(repository: careersRepositoryInstance)
    }
    
    func makeAddActivityUseCase() -> AddActivityUseCase {
        return DefaultAddActivityUseCase(repository: activityRepositoryInstance)
    }
    
    func makeDeleteActivityUseCase() -> DeleteActivityUseCase {
        return DefaultDeleteActivityUseCase(repository: activityRepositoryInstance)
    }
    
    func makeFetchActivityListUseCase() -> FetchActivityListUseCase {
        return DefaultFetchActivityListUseCase(repository: activityRepositoryInstance)
    }
    
}


// MARK: - Factories

extension AppDIContainer {
    
    func makeHomeFactory() -> HomeFactory {
        return DefaultHomeFactory(
            addPreUseCase: makeAddPreCertificationUseCase(),
            deletePreUseCase: makeDeletePreCertificationUseCase(),
            getPreUseCase: makeGetPreCertificationUseCase(),
            getFavoriteUseCase: makeGetFavoritePreCertificationUseCase(),
            fetchUserInfoUseCase: makeFetchUserInfoUseCase(),
            withDrawUseCase: makeWithDrawUseCase()
        )
    }
    
    func makeOnboardingFactory() -> OnboardingFactory {
        return DefaultOnboardingFactory(
            fetchMajorListUseCase: makeFetchMajorListUseCase(),
            fetchUnivListUseCase: makeFetchUnivListUseCase()
        )
    }
    
    func makeResumeFactory() -> ResumeFactory {
        return DefaultResumeFactory(
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
