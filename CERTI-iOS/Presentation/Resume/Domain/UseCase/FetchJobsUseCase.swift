//
//  FetchJobsUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol FetchJobsUseCase {
    func execute() async -> Result<[String], ResumeError>
}

struct FetchJobsUseCaseImpl: FetchJobsUseCase {
    private let repository: ResumeRepository
    init(repository: ResumeRepository) { self.repository = repository }

    func execute() async -> Result<[String], ResumeError> {
        return await repository.fetchJobs()
    }
}
