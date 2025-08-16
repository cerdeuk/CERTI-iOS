//
//  ResumeRepository.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol ResumeRepository {
    func fetchCareers() async throws -> [ResumeCareer]
    func addCareer(_ item: ResumeCareer) async throws
    func deleteCareer(id: Int) async throws

    func fetchActivities() async throws -> [ResumeActivity]
    func addActivity(_ item: ResumeActivity) async throws
    func deleteActivity(id: Int) async throws

    func fetchJobs() async throws -> [String]
}
