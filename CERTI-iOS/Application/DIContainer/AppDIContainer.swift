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

// MARK: - Repositories

extension AppDIContainer {

    func makeAuthRepository() -> AuthRepository {
        return DefaultAuthRepository()
    }
    
    func makeOnboardingRepository() -> OnboardingRepository {
        return DefaultOnboardingRepository()
    }
    
    
    
    func makeCertificationRepository() -> CertificationRepository {
        return DefaultCertificationRepository()
    }
    
    func makeJobRepository() -> JobRepository {
        return DefaultJobRepository()
    }
    
    func makeUserRepository() -> UserRepository {
        return DefaultUserRepository()
    }
    
    func makeHomeRepository() -> HomeRepository {
        return DefaultHomeRepository()
    }
    
    func makeAcquisitionRepository() -> AcquisitionRepository {
        return DefaultAcquisitionRepository()
    }
    
    func makeCareersRepository() -> CareersRepository {
        return DefaultCareersRepository()
    }
    
    func makeActivityRepository() -> ActivityRepository {
        return DefaultActivityRepository()
    }
    
}
