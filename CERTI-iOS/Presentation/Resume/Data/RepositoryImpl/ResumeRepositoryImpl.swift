//
//  ResumeRepositoryImpl.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

import os

final class ResumeRepositoryImpl: ResumeRepository {
    private let careersService: CareersServiceProtocol
    private let activityService: ActivityServiceProtocol
    private let acquisitionService: AcquisitionService
    private let jobService: JobsServiceProtocol
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Resume")
    
    init(
        careersService: CareersService,
        activityService: ActivityService,
        acquisitionService: AcquisitionService,
        jobService: JobService
    ) {
        self.careersService = careersService
        self.activityService = activityService
        self.acquisitionService = acquisitionService
        self.jobService = jobService
    }
    
    func fetchJobs() async -> Result<[String], ResumeError> {
        let result = await jobService.getFetchJob()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getJobList: No data received")
                return .failure(.noData)
            }
            logger.debug("✅ getJobList success: \(data.jobList)")
            return .success(data.jobList)
            
        case .failure(let error):
            logger.error("getJobList failed: \(error.localizedDescription)")
            return .failure(.network(error))
        }
    }
}
