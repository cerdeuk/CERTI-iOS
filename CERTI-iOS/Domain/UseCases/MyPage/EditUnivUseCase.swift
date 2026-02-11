//
//  EditUnivUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

protocol EditUnivUseCase {
    func execute(request: String) async -> Result<Void, NetworkError>
}

final class DefaultEditUnivUseCase: EditUnivUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(request: String) async -> Result<Void, NetworkError> {
        let result = await repository.editUniv(request: request)
        return result
    }
}
