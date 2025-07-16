//
//  ResumeViewModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/14/25.
//

import Foundation

import os

@MainActor
final class ResumeViewModel: ObservableObject {
    @Published var careerDummy: [ResumeModel] = ResumeModel.myCareerDummy()
    @Published var myExtracurricularActivityModelDummy: [ResumeModel] = ResumeModel.myExtracurricularActivityDummy()
    @Published var certificatedDummy: [CertificatedModel] = CertificatedModel.dummy()
    @Published var jobList: [String] = []
    @Published var acquisitionList: [CertificatedModel] = []
    @Published var acquisitionDetail: CertificatedModel = CertificatedModel(acquisitionId: 0, index: 0, name: "", createdAt: "", cardFrontImageUrl: "", cardBackImageUrl: "", tags: [], description: "")
    @Published var careersList: [ResumeModel] = []
    @Published var activityList: [ResumeModel] = []
    @Published var isPeriodFilled: Bool = false
    @Published var resumeModel = ResumeModel(
        startAt: "",
        endAt: "",
        name: "",
        place: "",
        discription: ""
    )
    var isWriteButtonEnabled: Bool {
        !resumeModel.name.isBlank && !resumeModel.place.isBlank && !resumeModel.discription.isBlank && isPeriodFilled
    }
    private let jobService = NetworkService.shared.jobService
    private let acquisitionService = NetworkService.shared.acquisitionService
    private let careersService = NetworkService.shared.careersService
    private let activityService = NetworkService.shared.activityService

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "Job")
}


// MARK: - Network

extension ResumeViewModel {
    func getJobList() async {
        let result = await jobService.getFetchJob()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getJobList: No data received")
                return
            }
            
            self.jobList = data.jobList
            logger.debug("✅ getJobList success: \(data.jobList)")
            
        case .failure(let error):
            logger.error("getJobList failed: \(error.localizedDescription)")
        }
    }
    
    func getAcquisitionList() async {
        let result = await acquisitionService.fetchAcquisitionList()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getAcquisitionList: No data received")
                return
            }
            
            self.acquisitionList = data.getAcquisitionResponses
            logger.debug("✅ getAcquisitionList success: \(data.getAcquisitionResponses)")
            
        case .failure(let error):
            logger.error("getAcquisitionList failed: \(error.localizedDescription)")
        }
    }
    
    func getAcquisitionDetail(id: Int) async {
        let result = await acquisitionService.fetchAcquisitionDetail(id: id)
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getAcquisitionDetail: No data received")
                return
            }
            
            self.acquisitionDetail = data
//            logger.debug("✅ getAcquisitionDetail success: \(data)")
            
        case .failure(let error):
            logger.error("getAcquisitionDetail failed: \(error.localizedDescription)")
        }
    }
    
    func getCareersList() async {
        let result = await careersService.fetchCareersList()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getCareersList: No data received")
                return
            }
            
            self.careersList = data.careerDetailResponseList.map { $0.toResumeModel() }
            logger.debug("✅ getCareersList success: \(data.careerDetailResponseList)")
            
        case .failure(let error):
            logger.error("getCareersList failed: \(error.localizedDescription)")
        }
    }

    func getActivityList() async {
        let result = await activityService.fetchActivityList()
        
        switch result {
        case .success(let response):
            guard let data = response.data else {
                logger.error("❌ getActivityList: No data received")
                return
            }
            
            self.activityList = data.activityDetailResponses.map { $0.toResumeModel() }
            logger.debug("✅ getActivityList success: \(data.activityDetailResponses)")
            
        case .failure(let error):
            logger.error("getActivityList failed: \(error.localizedDescription)")
        }
    }

}
