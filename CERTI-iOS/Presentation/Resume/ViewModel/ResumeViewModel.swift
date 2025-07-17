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
    
    func clearResumeModel() {
        resumeModel = ResumeModel(
            startAt: "",
            endAt: "",
            name: "",
            place: "",
            discription: ""
        )
        isPeriodFilled = false
    }
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
    
    func deleteAcquisition(id: Int) async {
        let result = await acquisitionService.deleteAcquisition(id: id)
        
        switch result {
        case .success(_):
            logger.info("✅ 취득한 자격증 삭제 성공")
            acquisitionList.removeAll { $0.acquisitionId == id }

        case .failure(let error):
            logger.error("취득한 자격증 삭제 failed: \(error.localizedDescription)")
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
    
    func addCareer(resumeModel: ResumeModel) async {
        let request = AddCareerRequestDTO(
            startAt: resumeModel.startAt,
            endAt: resumeModel.endAt,
            place: resumeModel.place,
            name: resumeModel.name,
            description: resumeModel.discription
        )

        let result = await careersService.addCareer(request: request)

        switch result {
        case .success(let result):
            logger.info("✅ 경력 추가 성공: \(result)")
        case .failure(_): break
//            logger.error("❌ 경력 추가 실패: \(error.localizedDescription)")
        }
    }
    
    func deleteCareers(id: Int) async {
        let result = await careersService.deledteCareers(id: id)
        
        switch result {
        case .success(_):
            logger.info("✅ 취득한 자격증 삭제 성공")
            careersList.removeAll { $0.careerId == id }

        case .failure(let error):
            logger.error("취득한 자격증 삭제 failed: \(error.localizedDescription)")
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

    func addActivity(resumeModel: ResumeModel) async {
        let request = AddActivityRequestDTO(
            startAt: resumeModel.startAt,
            endAt: resumeModel.endAt,
            place: resumeModel.place,
            name: resumeModel.name,
            description: resumeModel.discription
        )

        let result = await activityService.addActivity(request: request)

        switch result {
        case .success(let result):
            logger.info("✅ 활동 추가 성공: \(result)")
        case .failure(_): break
//            logger.error("❌ 활동 추가 실패: \(error.localizedDescription)")
        }
    }
}
