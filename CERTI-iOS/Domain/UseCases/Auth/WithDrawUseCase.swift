//
//  WithDrawUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/22/25.
//

import Foundation

protocol WithDrawUseCase {
    func execute() async -> Result<Void, NetworkError>
}

final class DefaultWithDrawUseCase: WithDrawUseCase {

    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute() async -> Result<Void, NetworkError> {
        await repository.withDraw()
    }
}
