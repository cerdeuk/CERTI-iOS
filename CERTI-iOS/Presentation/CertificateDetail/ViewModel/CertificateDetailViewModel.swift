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

    private let fetchDetail: FetchCertificateDetailUseCase
    private let appendPreCertification: AppendPreCertificationUseCase
    private let appendAcquisition: AppendAcquisitionUseCase
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "CertificationDetail")
    
    init(fetchDetail: FetchCertificateDetailUseCase,
         appendPreCertification: AppendPreCertificationUseCase,
         appendAcquisition: AppendAcquisitionUseCase) {
        self.fetchDetail = fetchDetail
        self.appendPreCertification = appendPreCertification
        self.appendAcquisition = appendAcquisition
    }
}


// MARK: - Network

extension CertificateDetailViewModel {
    func fetchCertificateDetail(certificationId: Int) async {
        do {
            let domain = try await fetchDetail.execute(id: certificationId)
            self.certificateDetailModel = domain.toPresentation()
            logger.debug("✅ CertificationDetail success: \(String(describing: self.certificateDetailModel))")
        } catch {
            logger.error("CertificationDetail failed: \(error.localizedDescription)")
        }
    }
    
    func onTapAppendPreCertification(id: Int) async {
        do {
            try await appendPreCertification.execute(id: id)
            showSuccessToBeAcquired = true
            logger.debug("✅ appendPreCertification success")
        } catch let e as AppendPreCertificationError {
            switch e {
            case .duplicationError:
                showFailToBeAcquired = true
            case .conflictError:
                showFailAcquired = true
            }
            logger.error("appendPreCertification domain failure: \(e.localizedDescription)")
        } catch {
            logger.error("appendPreCertification failed(Other): \(error.localizedDescription)")
        }
    }
    
    func onTapAppendAcquisition(id: Int) async {
        do {
            try await appendAcquisition.execute(id: id)
            showCompleteModal = true
            logger.debug("✅ appendPreCertification success")
        } catch let e as AppendAcquisitionError {
            switch e {
            case .duplicationError:
                showFailAcquired = true
            }
            logger.error("appendPreCertification domain failure: \(e.localizedDescription)")
        } catch {
            logger.error("appendPreCertification failed(Other): \(error.localizedDescription)")
        }
    }
}
