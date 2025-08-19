//
//  GetPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

protocol GetPreCertificationUseCase {
    func execute() async -> Result<PreCertificationEntity, NetworkError>
}

final class DefaultGetPreCertificationUseCase: GetPreCertificationUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<PreCertificationEntity, NetworkError> {
        return await repository.getPreCertification()
    }
    
}
