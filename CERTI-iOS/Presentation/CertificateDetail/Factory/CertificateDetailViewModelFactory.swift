//
//  CertificateDetailViewModelFactory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//


struct CertificateDetailViewModelFactory {
    
    @MainActor
    static func make() -> CertificateDetailViewModel {
        let certificationService: CertificationServiceProtocol = CertificationService()
        let homeService: HomeServiceProtocol = HomeService()
        let acquisitionService: AcquisitionServiceProtocol = AcquisitionService()
        
        let certificationRepository = CertificateRepositoryImpl(certificationService: certificationService)
        let homeRepository = HomeRepositoryImpl(homeService: homeService)
        let acquisitionRepository = AcquisitionRepositoryImpl(acquisitionService: acquisitionService)
        
        return CertificateDetailViewModel(
            fetchDetail: DefaultFetchCertificateDetailUseCase(repository: certificationRepository),
            appendPreCertification: DefaultAppendPreCertificationUseCase(repository: homeRepository),
            appendAcquisition: DefaultAppendAcquisitionUseCase(repository: acquisitionRepository)
        )
    }
}
