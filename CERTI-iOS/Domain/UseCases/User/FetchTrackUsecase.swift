//
//  FetchTrackUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/29/26.
//

import Foundation

protocol FetchTrackUsecase {
    func execute() async -> Result<String, NetworkError>
}

final class DefaultFetchTrackUsecase: FetchTrackUsecase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<String, NetworkError> {
        return await repository.getTrack()
    }
}
