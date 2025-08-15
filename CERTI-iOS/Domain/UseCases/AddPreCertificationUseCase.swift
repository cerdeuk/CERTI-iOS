//
//  AddPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

protocol AddPreCertificationUseCase {
    func execute(certificationId: Int) async -> Result<Bool, NetworkError>
}

final class DefaultAddPreCertificationUseCase: AddPreCertificationUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute(certificationId: Int) async -> Result<Bool, NetworkError> {
        let result = await repository.addPreCertification(certificationId: certificationId)
        return result.map { $0.data ?? false }
    }
    
}
