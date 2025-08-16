//
//  CertificateDetialImpl.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

import Foundation

enum AppendError: LocalizedError, Equatable {
    case duplicationError
}

final class CertificateDetialImpl: CertificateDetailRepository {
    
    private let certificationService: CertificationServiceProtocol
        private let homeService: HomeServiceProtocol
        private let acquisitionService: AcquisitionServiceProtocol

        init(certificationService: CertificationServiceProtocol,
             homeService: HomeServiceProtocol,
             acquisitionService: AcquisitionServiceProtocol) {
            self.certificationService = certificationService
            self.homeService = homeService
            self.acquisitionService = acquisitionService
        }
    
    public func fetchDetail(id: Int) async throws -> CertificateDetail {
        let result = await certificationService.fetchCertificationDetail(certificationId: id)
        
        switch result {
        case .success(let response):
            guard let dto = response.data else { throw NetworkError.decodingError
            }
            return dto.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
    func appendPreCertification(id: Int) async throws {
        let result = await homeService.addPreCertification(certificationId: id)

        switch result {
        case .success(let response):
            if response.status == 409 {
                throw NetworkError.conflict
            }
            guard let ok = response.data else {
                throw NetworkError.decodingError
            }
            if ok { return } else {
                throw AppendError.duplicationError
            }
            
        case .failure(let error):
            throw error
        }
    }
    
    func appendAcquisition(id: Int) async throws {
        let result = await acquisitionService.addAcquisition(certificationId: id)

        switch result {
        case .success(let response):
            guard let ok = response.data else {
                throw NetworkError.decodingError
            }
            if ok { return } else {
                throw AppendError.duplicationError
            }
        case .failure(let error):
            throw error
        }
    }
}
