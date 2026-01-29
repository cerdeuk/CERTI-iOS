//
//  EditMajorUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/27/26.
//

import Foundation

protocol EditMajorUseCase {
    func execute(request: String) async -> Result<Void, NetworkError>
}

final class DefaultEditMajorUseCase: EditMajorUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(request: String) async -> Result<Void, NetworkError> {
        let result = await repository.editMajor(request: request)
        return result
    }
}
