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
    @Published var acquisitionDetail: CertificatedDetailModel? = nil
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
    @Published var isCardDetailPresented = false
    
    var isWriteButtonEnabled: Bool {
        !resumeModel.name.isBlank && !resumeModel.place.isBlank && !resumeModel.discription.isBlank && isPeriodFilled
    }
    private let jobService = AppDIContainer.shared.makeJobRepository()
    private let acquisitionService = AppDIContainer.shared.makeAcquisitionRepository()
    private let careersService = AppDIContainer.shared.makeCareersRepository()
    private let activityService = AppDIContainer.shared.makeActivityRepository()
    
    private let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    private let fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    private let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    
    private let addCareersUseCase: AddCareersUseCase
    private let deleteCareersUseCase: DeleteCareersUseCase
    private let fetchCareersListUseCase: FetchCareersListUseCase
    
    private let addActivityUseCase: AddActivityUseCase
    private let deleteActivityUseCase: DeleteActivityUseCase
    private let fetchActivityListUseCase: FetchActivityListUseCase
    
    init(
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase,
        deleteAcquisitionUseCase: DeleteAcquisitionUseCase,
        addCareersUseCase: AddCareersUseCase,
        deleteCareersUseCase: DeleteCareersUseCase,
        fetchCareersListUseCase: FetchCareersListUseCase,
        addActivityUseCase: AddActivityUseCase,
        deleteActivityUseCase: DeleteActivityUseCase,
        fetchActivityListUseCase: FetchActivityListUseCase
    ) {
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.fetchAcquisitionDetailUseCase = fetchAcquisitionDetailUseCase
        self.deleteAcquisitionUseCase = deleteAcquisitionUseCase
        self.addCareersUseCase = addCareersUseCase
        self.deleteCareersUseCase = deleteCareersUseCase
        self.fetchCareersListUseCase = fetchCareersListUseCase
        self.addActivityUseCase = addActivityUseCase
        self.deleteActivityUseCase = deleteActivityUseCase
        self.fetchActivityListUseCase = fetchActivityListUseCase
    }

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
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "resume")
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
        let result = await fetchAcquisitionListUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 취득한 자격증 목록 조회 성공")
            self.acquisitionList = response.toCertificatedModel()
            
        case .failure(let error):
            logger.error("❌ 취득한 자격증 목록 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func getAcquisitionDetail(id: Int) async {
        let result = await fetchAcquisitionDetailUseCase.excute(id: id)
        
        switch result {
        case .success(let response):
            logger.info("✅ 취득한 자격증 상세 조회 성공")
            self.acquisitionDetail = response.acquisitionDetail.toCertificatedDetailModel()
            
        case .failure(let error):
            logger.error("❌ 취득한 자격증 상세 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func deleteAcquisition(id: Int) async {
        let result = await deleteAcquisitionUseCase.execute(id: id)
        
        switch result {
        case .success(_):
            logger.info("✅ 취득한 자격증 삭제 성공")
            acquisitionList.removeAll { $0.acquisitionId == id }

        case .failure(let error):
            logger.error("취득한 자격증 삭제 failed: \(error.localizedDescription)")
        }
    }

    
    func getCareersList() async {
        let result = await fetchCareersListUseCase.execute()
        
        switch result {
        case .success(let response):
            self.careersList = response.toResumeModel()
            logger.debug("✅ 경력사항 조회 성공")
            
        case .failure(let error):
            logger.error("❌ 경력사항 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func addCareer(resumeModel: ResumeModel) async {
        let result = await addCareersUseCase.execute(request: resumeModel.toCareersEntity())

        switch result {
        case .success:
            logger.info("✅ 경력 추가 성공")
        case .failure(let error):
            logger.error("❌ 경력 추가 실패: \(error.localizedDescription)")
        }
    }
    
    func deleteCareers(id: Int) async {
        let result = await deleteCareersUseCase.execute(id: id)
        
        switch result {
        case .success(_):
            logger.info("✅ 취득한 자격증 삭제 성공")
            careersList.removeAll { $0.careerId == id }

        case .failure(let error):
            logger.error("취득한 자격증 삭제 failed: \(error.localizedDescription)")
        }
    }


    func getActivityList() async {
        let result = await fetchActivityListUseCase.execute()
        
        switch result {
        case .success(let response):
            self.activityList = response.toResumeModel()
            logger.debug("✅ 대내외활동 조회 성공")
            
        case .failure(let error):
            logger.error("❌ 대내외활동 조회 실패: \(error.localizedDescription)")
        }
    }

    
    func deleteActivity(id: Int) async {
        let result = await deleteActivityUseCase.execute(id: id)
        
        switch result {
        case .success(_):
            logger.info("✅ 대내외 활동 삭제 성공")
            activityList.removeAll { $0.activityId == id }

        case .failure(let error):
            logger.error("대내외 활동 삭제 failed: \(error.localizedDescription)")
        }
    }

    func addActivity(resumeModel: ResumeModel) async {
        let result = await addActivityUseCase.execute(request: resumeModel.toActivityEntity())

        switch result {
        case .success:
            logger.info("✅ 활동 추가 성공")
        case .failure(let error):
            logger.error("❌ 활동 추가 실패: \(error.localizedDescription)")
        }
    }
}
