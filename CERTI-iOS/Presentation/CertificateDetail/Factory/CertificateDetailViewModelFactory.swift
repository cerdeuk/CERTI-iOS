//
//  CertificateDetailViewModelFactory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//


struct CertificateDetailViewModelFactory {
    
    @MainActor
    static func make() -> CertificateDetailViewModel {
        let certService: CertificationServiceProtocol = CertificationService()
        let homeService: HomeServiceProtocol = HomeService()
        let acquisitionService: AcquisitionServiceProtocol = AcquisitionService()
        
        let repo = CertificateDetailRepositoryImpl(
            certificationService: certService,
            homeService: homeService,
            acquisitionService: acquisitionService
        )
        
        return CertificateDetailViewModel(
            fetchDetail: DefaultFetchCertificateDetailUseCase(repository: repo),
            appendPreCertification: DefaultAppendPreCertificationUseCase(repository: repo),
            appendAcquisition: DefaultAppendAcquisitionUseCase(repository: repo)
        )
    }
}
