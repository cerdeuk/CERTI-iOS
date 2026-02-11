//
//  AddPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

protocol AddPreCertificationUseCase {
    func execute(request: AddPreCertificationEntity) async -> Result<AppendPreCertificationStatus, NetworkError>
}

final class DefaultAddPreCertificationUseCase: AddPreCertificationUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute(request: AddPreCertificationEntity) async -> Result<AppendPreCertificationStatus, NetworkError> {
        let result = await repository.addPreCertification(request: request)
        return result
    }
}
