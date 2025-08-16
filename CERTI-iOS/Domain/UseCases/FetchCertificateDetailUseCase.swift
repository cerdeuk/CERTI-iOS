//
//  FetchCertificateDetailUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol FetchCertificateDetailUseCase {
    func execute(id: Int) async throws -> CertificateDetail
}

final class DefaultFetchCertificateDetailUseCase: FetchCertificateDetailUseCase {
    
    private let repository: CertificateDetailRepository
    
    init(
        repository: CertificateDetailRepository
    ) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> CertificateDetail {
        try await repository.fetchDetail(id: id)
    }
}
