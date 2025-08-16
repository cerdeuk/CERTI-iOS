//
//  FetchCareersUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol FetchCareersUseCase {
    func execute() async throws -> [ResumeCareer]
}

final class DefaultFetchCareersUseCase: FetchCareersUseCase {
    private let repository: ResumeRepository

    init(repository: ResumeRepository) {
        self.repository = repository
    }

    func execute() async throws -> [ResumeCareer] {
        return try await repository.fetchCareers()
    }
}
