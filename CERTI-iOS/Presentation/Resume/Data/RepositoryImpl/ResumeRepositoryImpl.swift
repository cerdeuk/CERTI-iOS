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
    
    init(careersService: CareersServiceProtocol) {
        self.careersService = careersService
    }
    
    func fetchCareers() async -> Result<[ResumeCareer], ResumeError> {
        <#code#>
    }
    
    func addCareer(_ item: ResumeCareer) async -> Result<Void, ResumeError> {
        <#code#>
    }
    
    func deleteCareer(id: Int) async -> Result<Void, ResumeError> {
        <#code#>
    }
    
    func fetchActivities() async -> Result<[ResumeActivity], ResumeError> {
        <#code#>
    }
    
    func addActivity(_ item: ResumeActivity) async -> Result<Void, ResumeError> {
        <#code#>
    }
    
    func deleteActivity(id: Int) async -> Result<Void, ResumeError> {
        <#code#>
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
    func fetchAcquisitionList() async -> Result<[CertificatedListModel], ResumeError> {
        let result = await acquisitionService.fetchAcquisitionList()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ fetchAcquisitionList: No data received")
                return .failure(.noData)
            }
            logger.debug("✅ fetchAcquisitionList success: \(data.acquisitionListDetailResponses)")
            return .success(data.acquisitionListDetailResponses.map { $0.toDomain() })
            
        case .failure(let error):
            logger.error("fetchAcquisitionList failed: \(error.localizedDescription)")
            return .failure(.network(error))
        }
    }
    
    func fetchAcquisitionDetail(id: Int) async -> Result<CertificatedDetailModel, ResumeError> {
        <#code#>
    }
    
    func deleteAcquisition(id: Int) async -> Result<Void, ResumeError> {
        <#code#>
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
}
