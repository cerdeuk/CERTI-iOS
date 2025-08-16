//
//  ResumeRepositoryImpl.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

final class ResumeRepositoryImpl: ResumeRepository {
    private let careersService: CareersServiceProtocol
    private let activityService: ActivityServiceProtocol
    private let jobService: JobsServiceProtocol

    init(careersService: CareersServiceProtocol) {
        self.careersService = careersService
    }

    func fetchCareers() async throws -> [ResumeCareer] {
        let result = await careersService.fetchCareersList()
        switch result {
        case .success(let response):
            guard let data = response.data else { return [] }
            return data.careerDetailResponseList.map { $0.toDomain() }

        case .failure(let error):
            throw error
        }
    }

    // 다른 메서드도 마찬가지로 구현
}
