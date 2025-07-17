//
//  CertificateDetailViewModel.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/16/25.
//

import SwiftUI

import os

@MainActor
final class CertificateDetailViewModel: ObservableObject {
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
    @Published var showCompleteModal = false

    
    private let certificateDetailService = NetworkService.shared.certificationService
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Certification")
    
    private let homeService = NetworkService.shared.homeService
    private let homeLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Home")
    
    private let acquisitionService = NetworkService.shared.acquisitionService
    private let acquisitionLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Acquisition")
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
        case .success(let response):
            guard let data = response.data else {
                homeLogger.error("❌ appendPreCertification: No data received")
                return
            }
            
            if data {
                showSuccessToBeAcquired = true
            } else {
                showFailToBeAcquired = true
            }
            homeLogger.debug("✅ appendPreCertification success: \(data)")
            
        case .failure(let error):
            homeLogger.error("appendPreCertification failed: \(error.localizedDescription)")
        }
    }
    
    func appendAcquisition(certification: Int) async {
        let result = await acquisitionService.addAcquisition(certificationId: certification)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                acquisitionLogger.error("❌ appendAcquisition: No data received")
                return
            }
            
            if data {
                showCompleteModal = true
            } else {
                showFailAcquired = true
            }
            acquisitionLogger.debug("✅ appendAcquisition success: \(data)")
            
        case .failure(let error):
            acquisitionLogger.error("appendAcquisition failed: \(error.localizedDescription)")
        }
    }
}
