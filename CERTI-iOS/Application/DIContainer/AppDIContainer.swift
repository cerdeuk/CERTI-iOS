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
    func makeHomeUseCase() -> HomeUseCase {
        return DefaultHomeUseCase(repository: makeHomeRepository())
    }
    
}


// MARK: - ViewModel

extension AppDIContainer {
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(homeUseCase: makeHomeUseCase())
    }
    
}
