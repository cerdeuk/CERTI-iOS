//
//  FetchCareersListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol FetchCareersListUseCase {
    func execute() async -> Result<[ResumeModel], ResumeError>
}

struct FetchCareersListUseCaseImpl: FetchCareersListUseCase {
    private let repository: ResumeRepository
    init(repository: ResumeRepository) { self.repository = repository }

    func execute() async -> Result<[ResumeModel], ResumeError> {
        let result = await repository.fetchCareers()
        return result.map { $0.map { $0.toResumeModel() } }
    }
}
