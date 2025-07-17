//
//  CertificateDetailViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import SwiftUI

import os

@MainActor
class CertificateDetailViewModel: ObservableObject {
    @Published var certificateDetailModel = CertificateDetailModel(
        certificationId: 0,
        certificationName: "",
        tags: [],
        averagePeriod: "",
        charge: "0",
        agencyName: "",
        testType: "",
        description: "",
        testDateInformation: "",
        applicationMethod: "",
        applicationUrl: "www.google.com",
        expirationPeriod: ""
    )
    @Published var showSuccessToBeAcquired: Bool = false
    @Published var showFailAcquired: Bool = false
    @Published var showFailToBeAcquired: Bool = false
    
    private let certificateDetailService = NetworkService.shared.certificationService
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Certification")
    
    private let homeService = NetworkService.shared.homeService
    private let homeLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Home")
}


// MARK: - Network

extension CertificateDetailViewModel {
    func fetchCertificateDetail(certificationId: Int) async {
        let result = await certificateDetailService.fetchCertificationDetail(certificationId: certificationId)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getCertificationDetailList: No data received")
                return
            }
            self.certificateDetailModel = data.toDomain()
            logger.debug("✅ CertificationDetail success: \(String(describing: self.certificateDetailModel))")
            
        case .failure(let error):
            logger.error("CertificationDetail failed: \(error.localizedDescription)")
        }
    }
    
    func appendPreCertification(certification: Int) async {
        let result = await homeService.addPreCertification(certificationId: certification)
        
        switch result {
        case .success(_):
            logger.debug("✅ appendPreCertification success")
            
        case .failure(let error):
            logger.error("appendPreCertification failed: \(error.localizedDescription)")
        }
    }
}
