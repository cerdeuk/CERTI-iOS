//
//  GetFavoriteCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/16/25.
//

import Foundation

protocol GetFavoriteCertificationUseCase {
    func execute() async -> Result<FavoriteCertificationEntity, NetworkError>
}

final class DefaultGetFavoriteCertificationUseCase: GetFavoriteCertificationUseCase {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<FavoriteCertificationEntity, NetworkError> {
        return await repository.getFavoriteCertification()
    }
    
}
