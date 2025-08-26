//
//  SwitchFavoriteUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import Foundation

protocol SwitchFavoriteUseCase {
    func execute(id: Int) async -> Result<Void, NetworkError>
}

final class DefaultSwitchFavoriteUseCase: SwitchFavoriteUseCase {
    private let repository: CertificationRepository
    
    init(repository: CertificationRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async -> Result<Void, NetworkError> {
        return await repository.switchFavorite(certificationId: id)
    }
}
