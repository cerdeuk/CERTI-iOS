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

    
    private let certificateDetailService = AppDIContainer.shared.certificationRepository
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "CertificationDetail")
    
    private let homeService = AppDIContainer.shared.homeRepository
    
    private let acquisitionService = AppDIContainer.shared.acquisitionRepository
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
                if response.status == 409  {
                    showFailAcquired = true
                    return
                } else {
                    logger.error("❌ appendPreCertification: No data received")
                    return
                }
            }
            
            if data {
                showSuccessToBeAcquired = true
            } else {
                showFailToBeAcquired = true
            }
            logger.debug("✅ appendPreCertification success: \(data)")
            
        case .failure(let error):
            logger.error("appendPreCertification failed: \(error.localizedDescription)")
        }
    }
    
    func appendAcquisition(certification: Int) async {
        let result = await acquisitionService.addAcquisition(certificationId: certification)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ appendAcquisition: No data received")
                return
            }
            
            if data {
                showCompleteModal = true
            } else {
                showFailAcquired = true
            }
            logger.debug("✅ appendAcquisition success: \(data)")
            
        case .failure(let error):
            logger.error("appendAcquisition failed: \(error.localizedDescription)")
        }
    }
}
