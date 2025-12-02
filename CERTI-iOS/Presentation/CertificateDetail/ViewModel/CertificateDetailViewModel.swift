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
    @Published var CertificationPlanDate: Date? = nil
    @Published var CertificationPlanPlaceDo: String? = nil
    @Published var CertificationPlanPlaceSi: String? = nil

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "CertificationDetail")
    
    private let fetchCertificationDetailUseCase: FetchCertificationDetailUseCase
    private let addPreCertificationUseCase: AddPreCertificationUseCase
    private let addAcquisitionUseCase: AddAcquisitionUseCase
    
    init(
        fetchCertificationDetailUseCase: FetchCertificationDetailUseCase,
        addPreCertificationUseCase: AddPreCertificationUseCase,
        addAcquisitionUseCase: AddAcquisitionUseCase
    ) {
        self.fetchCertificationDetailUseCase = fetchCertificationDetailUseCase
        self.addPreCertificationUseCase = addPreCertificationUseCase
        self.addAcquisitionUseCase = addAcquisitionUseCase
    }
}


// MARK: - Network

extension CertificateDetailViewModel {
    func fetchCertificateDetail(certificationId: Int) async {
        let result = await fetchCertificationDetailUseCase.execute(id: certificationId)
        
        switch result {
        case .success(let response):
            self.certificateDetailModel = response.toCertificationDetailModel()
            logger.debug("✅ CertificationDetail success: \(String(describing: self.certificateDetailModel))")
            
        case .failure(let error):
            logger.error("CertificationDetail failed: \(error.localizedDescription)")
        }
    }
    
    func appendPreCertification(certificationId: Int) async {
        let result = await addPreCertificationUseCase.execute(certificationId: certificationId)
        
        switch result {
        case .success(let status):
            switch status {
            case .success: showSuccessToBeAcquired = true
            case .conflictError: showFailAcquired = true
            case .duplicationError: showFailToBeAcquired = true
            }
            logger.debug("✅ appendPreCertification success")
            
        case .failure(let error):
            logger.error("appendPreCertification failed: \(error.localizedDescription)")
        }
    }
    
    func appendAcquisition(certificationId: Int) async {
        let result = await addAcquisitionUseCase.execute(certificationId: certificationId)

        switch result {
        case .success(let response):
            if response {
                showCompleteModal = true
            } else {
                showFailAcquired = true
            }
            logger.debug("✅ appendAcquisition success")
            
        case .failure(let error):
            logger.error("appendAcquisition failed: \(error.localizedDescription)")
        }
    }
}
