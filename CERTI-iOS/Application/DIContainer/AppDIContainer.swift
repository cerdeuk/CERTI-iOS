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
    
    private lazy var homeRepository: HomeRepository = {
        return DefaultHomeRepository(service: makeHomeService())
    }()
    
}

// MARK: - PersistentStorage

extension AppDIContainer {
    func maketokenRefreshService() -> TokenRefreshServiceProtocol {
        return TokenRefreshService()
    }
}

// MARK: - Network Service

extension AppDIContainer {
    func makeHomeService() -> HomeServiceProtocol {
        return HomeService()
    }
    
    func makeAuthService() -> AuthServiceProtocol {
        return AuthService()
    }
    
    func makeOnboardingService() -> OnboardingServiceProtocol {
        return OnboardingService()
    }
    
    func makeCertificationService() -> CertificationServiceProtocol {
        return CertificationService()
    }
    
    func makeJobService() -> JobsServiceProtocol {
        return JobService()
    }
    
    func makeUserService() -> UserServiceProtocol {
        return UserService()
    }
    
    func makeAcquisitionService() -> AcquisitionServiceProtocol {
        return AcquisitionService()
    }
    
    func makeCareersService() -> CareersServiceProtocol {
        return CareersService()
    }
    
    func makeActivityService() -> ActivityServiceProtocol {
        return ActivityService()
    }
}

// MARK: - Repositories


/// makeRepository() 구조로 하니까 UseCase마다 필요한 레포지토리를 계속 만들게 돼서
/// UseCase 다 만들고 뷰모델도 다 이곳에서 관리하게 되면 이거처럼 RepositoryInstance로 만들어서 중복생성 안 하게 방지해야댐
/// 뭔가 다른 더 좋은 구조가 있을 것 같은데 좀 더 고민해보기

//extension AppDIContainer {
//    
//    private var authRepositoryInstance: AuthRepository {
//        return DefaultAuthRepository(service: makeAuthService())
//    }
//    
//    private var onboardingRepositoryInstance: OnboardingRepository {
//        return DefaultOnboardingRepository(service: makeOnboardingService())
//    }
//    
//    private var certificationRepositoryInstance: CertificationRepository {
//        return DefaultCertificationRepository(service: makeCertificationService())
//    }
//    
//    private var jobRepositoryInstance: JobRepository {
//        return DefaultJobRepository(service: makeJobService())
//    }
//    
//    private var userRepositoryInstance: UserRepository {
//        return DefaultUserRepository(service: makeUserService())
//    }
//    
//    private var homeRepositoryInstance: HomeRepository {
//        return DefaultHomeRepository(service: makeHomeService())
//    }
//    
//    private var acquisitionRepositoryInstance: AcquisitionRepository {
//        return DefaultAcquisitionRepository(service: makeAcquisitionService())
//    }
//
//    private var careersRepositoryInstance: CareersRepository {
//        return DefaultCareersRepository(service: makeCareersService())
//    }
//    
//    private var activityRepositoryInstance: ActivityRepository {
//        return DefaultActivityRepository(service: makeActivityService())
//    }
//    
//}

extension AppDIContainer {
    
    func makeAuthRepository() -> AuthRepository {
        return DefaultAuthRepository(service: makeAuthService())
    }
    
    func makeOnboardingRepository() -> OnboardingRepository {
        return DefaultOnboardingRepository(service: makeOnboardingService())
    }
    
    func makeCertificationRepository() -> CertificationRepository {
        return DefaultCertificationRepository(service: makeCertificationService())
    }
    
    func makeJobRepository() -> JobRepository {
        return DefaultJobRepository(service: makeJobService())
    }
    
    func makeUserRepository() -> UserRepository {
        return DefaultUserRepository(service: makeUserService())
    }
    
    func makeHomeRepository() -> HomeRepository {
        return DefaultHomeRepository(service: makeHomeService())
    }
    
    func makeAcquisitionRepository() -> AcquisitionRepository {
        return DefaultAcquisitionRepository(service: makeAcquisitionService())
    }
    
    func makeCareersRepository() -> CareersRepository {
        return DefaultCareersRepository(service: makeCareersService())
    }
    
    func makeActivityRepository() -> ActivityRepository {
        return DefaultActivityRepository(service: makeActivityService())
    }
    
}


// MARK: - UseCase

extension AppDIContainer {
    private var homeRepositoryInstance: HomeRepository {
        return DefaultHomeRepository(service: makeHomeService())
    }
    private var acquisitionRepositoryInstance: AcquisitionRepository {
        return DefaultAcquisitionRepository(service: makeAcquisitionService())
    }
    
    func makeAddPreCertificationUseCase() -> AddPreCertificationUseCase {
        return DefaultAddPreCertificationUseCase(repository: homeRepositoryInstance)
    }
    
    func makeDeletePreCertificationUseCase() -> DeletePreCertificationUseCase {
        return DefaultDeletePreCertificationUseCase(repository: homeRepositoryInstance)
    }
    
    func makeGetPreCertificationUseCase() -> GetPreCertificationUseCase {
        return DefaultGetPreCertificationUseCase(repository: homeRepositoryInstance)
    }
    
    func makeGetFavoritePreCertificationUseCase() -> GetFavoriteCertificationUseCase {
        return DefaultGetFavoriteCertificationUseCase(repository: homeRepositoryInstance)
    }
    
    func makeFetchAcquisitionListUseCase() -> FetchAcquisitionListUseCase {
        return DefaultFetchAcquisitionListUseCase(repository: acquisitionRepositoryInstance)
    }
    
}

// MARK: - Factories

extension AppDIContainer {
    
    func makeHomeFactory() -> HomeFactory {
        return DefaultHomeFactory(
            addPreUseCase: makeAddPreCertificationUseCase(),
            deletePreUseCase: makeDeletePreCertificationUseCase(),
            getPreUseCase: makeGetPreCertificationUseCase(),
            getFavoriteUseCase: makeGetFavoritePreCertificationUseCase()
        )
    }
    
    func makeResumeFactory() -> ResumeFactory {
        return DefaultResumeFactory(
            fetchAcquisitionListUseCase: makeFetchAcquisitionListUseCase()
        )
    }
    
}
