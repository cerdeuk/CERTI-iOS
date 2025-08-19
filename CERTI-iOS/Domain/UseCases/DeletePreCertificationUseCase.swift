//
//  DeletePreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

protocol DeletePreCertificationUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError>
}

final class DefaultDeletePreCertificationUseCase: DeletePreCertificationUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<Void, NetworkError> {
        await repository.deletePreCertification(id: id)
    }
    
}
