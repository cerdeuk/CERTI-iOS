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
    @Published var certificateDetailModel = CertificateDetailModel()
    
    private let certificateDetailService = NetworkService.shared.certificationService
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Certification")
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
            
            self.certificateDetailModel = data.
        }
    }
}
