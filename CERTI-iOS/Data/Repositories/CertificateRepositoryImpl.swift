//
//  CertificateRepositoryImpl.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

import Foundation

final class CertificateRepositoryImpl: CertificateRepository {
    
    private let certificationService: CertificationServiceProtocol
    
    init(certificationService: CertificationServiceProtocol) {
        self.certificationService = certificationService
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
}
