//
//  AppendAcquisitionUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/16/25.
//

protocol AppendAcquisitionUseCase {
    func execute(id: Int) async throws
}

final class DefaultAppendAcquisitionUseCasee: AppendAcquisitionUseCase {
    
    private let repository: CertificateDetailRepository
    
    init(
        repository: CertificateDetailRepository
    ) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws {
        try await repository.appendAcquisition(id: id)
    }
}
