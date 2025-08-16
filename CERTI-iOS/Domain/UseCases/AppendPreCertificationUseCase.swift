//
//  AppendPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol AppendPreCertificationUseCase {
    func execute(id: Int) async throws
}

final class DefaultAppendPreCertificationUseCase: AppendPreCertificationUseCase {
    
    private let repository: CertificateDetailRepository
    
    init(
        repository: CertificateDetailRepository
    ) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws {
        try await repository.appendPreCertification(id: id)
    }
}
