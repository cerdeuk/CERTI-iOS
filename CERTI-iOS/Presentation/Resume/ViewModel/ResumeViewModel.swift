//
//  ResumeViewModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/14/25.
//

import Foundation

import os

enum ResumeViewRoute: Equatable {
    case navigateToCareerWrite(mode: CareerWriteMode)
    case navigateToActivityWrite
    case navigateToCertificatedEdit
    case navigateToCareerManage
    case navigateToActivityManage
    
    case resumeViewRoutePop
}

enum CareerWriteMode: Hashable {
    case add
    case edit(careerId: Int)
}

@MainActor
final class ResumeViewModel: ObservableObject {
    @Published var resumeViewRoute: ResumeViewRoute?
    @Published var jobList: [String] = []
    @Published var acquisitionList: [CertificatedModel] = []
    @Published var acquisitionDetail: CertificatedDetailModel? = nil
    @Published var careersList: [CareerModel] = []
    @Published var activitiesList: [ActivityModel] = []
    @Published var isPeriodFilled: Bool = false
    @Published var careerWriteModel = CareerWriteModel()
    @Published var activityWriteModel = ActivityWriteModel()
    @Published var isCardDetailPresented = false
    @Published var selectCareerId: Int = 0
    
    var isCareerWriteButtonEnabled: Bool {
        !careerWriteModel.name.isBlank && !careerWriteModel.place.isBlank && !careerWriteModel.description.isBlank && isPeriodFilled
    }
    
    var isActivityWriteButtonEnabled: Bool {
        !activityWriteModel.name.isBlank && !activityWriteModel.place.isBlank && !activityWriteModel.description.isBlank && isPeriodFilled
    }
    
    private let fetchJobUseCase: FetchJobUseCase
    
    private let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    private let fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    private let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    
    private let addCareersUseCase: AddCareersUseCase
    private let deleteCareersUseCase: DeleteCareersUseCase
    private let fetchCareersListUseCase: FetchCareersListUseCase
    private let editCareerUseCase: EditCareersUseCase
    
    private let addActivityUseCase: AddActivityUseCase
    private let deleteActivityUseCase: DeleteActivityUseCase
    private let fetchActivityListUseCase: FetchActivityListUseCase
    
    init(
        fetchJobUseCase: FetchJobUseCase,
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase,
        deleteAcquisitionUseCase: DeleteAcquisitionUseCase,
        addCareersUseCase: AddCareersUseCase,
        deleteCareersUseCase: DeleteCareersUseCase,
        fetchCareersListUseCase: FetchCareersListUseCase,
        editCareerUseCase: EditCareersUseCase,
        addActivityUseCase: AddActivityUseCase,
        deleteActivityUseCase: DeleteActivityUseCase,
        fetchActivityListUseCase: FetchActivityListUseCase
    ) {
        self.fetchJobUseCase = fetchJobUseCase
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.fetchAcquisitionDetailUseCase = fetchAcquisitionDetailUseCase
        self.deleteAcquisitionUseCase = deleteAcquisitionUseCase
        self.addCareersUseCase = addCareersUseCase
        self.deleteCareersUseCase = deleteCareersUseCase
        self.fetchCareersListUseCase = fetchCareersListUseCase
        self.editCareerUseCase = editCareerUseCase
        self.addActivityUseCase = addActivityUseCase
        self.deleteActivityUseCase = deleteActivityUseCase
        self.fetchActivityListUseCase = fetchActivityListUseCase
    }
    
    func clearCareerWriteModel() {
        careerWriteModel = CareerWriteModel(
            startAt: "",
            endAt: "",
            name: "",
            place: "",
            description: ""
        )
        isPeriodFilled = false
    }
    
    func clearActivityWriteModel() {
        activityWriteModel = ActivityWriteModel(
            startAt: "",
            endAt: "",
            name: "",
            place: "",
            description: ""
        )
        isPeriodFilled = false
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CERTI", category: "resume")
}


// MARK: - Navigation Func

extension ResumeViewModel {
    
    func navigateToCareerWrite() {
        resumeViewRoute = .navigateToCareerWrite(mode: .add)
    }
    
    func navigateToCareerEdit2() {
        resumeViewRoute = .navigateToCareerWrite(mode: .edit(careerId: selectCareerId))
    }
    
    func navigateToActivityWrite() {
        resumeViewRoute = .navigateToActivityWrite
    }
    
    func navigateToCertificatedEdit() {
        resumeViewRoute = .navigateToCertificatedEdit
    }
    
    func navigateToCareerManage() {
        resumeViewRoute = .navigateToCareerManage
    }
    
    func navigateToActivityManage() {
        resumeViewRoute = .navigateToActivityManage
    }
    
    func resumeViewRoutePop() {
        resumeViewRoute = .resumeViewRoutePop
    }
}


// MARK: - Network

extension ResumeViewModel {
    func getJobList() async {
        let result = await fetchJobUseCase.execute()
        
        switch result {
        case .success(let response):
            logger.info("✅ 희망직무 조회 성공")
            self.jobList = response.toJobListModel().jobList
            
        case .failure(let error):
            logger.error("❌ 희망직무 조회 실패: \(error.localizedDescription)")
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
            self.careersList = response.toCareerModels()
            logger.debug("✅ 경력사항 조회 성공")
            
        case .failure(let error):
            logger.error("❌ 경력사항 조회 실패: \(error.localizedDescription)")
        }
    }
    
    func addCareer(careerWriteModel: CareerWriteModel) async {
        let result = await addCareersUseCase.execute(request: careerWriteModel.toCareerEntity())
        
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
    
    func editCareer(careerId: Int, careerWriteModel: CareerWriteModel) async {
        let result = await editCareerUseCase.execute(careerId: careerId, request: careerWriteModel.toCareerEntity())
        
        switch result {
        case .success(_):
            logger.info("✅ 경력 수정 성공")
            
        case .failure(let error):
            logger.error("❌경력 수정 failed: \(error.localizedDescription)")
        }
    }
    
    func getActivityList() async {
        let result = await fetchActivityListUseCase.execute()
        
        switch result {
        case .success(let response):
            self.activitiesList = response.toActivityModels()
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
            activitiesList.removeAll { $0.activityId == id }
            
        case .failure(let error):
            logger.error("대내외 활동 삭제 failed: \(error.localizedDescription)")
        }
    }
    
    func addActivity(activityWriteModel: ActivityWriteModel) async {
        let result = await addActivityUseCase.execute(request: activityWriteModel.toActivityEntity())
        
        switch result {
        case .success:
            logger.info("✅ 활동 추가 성공")
        case .failure(let error):
            logger.error("❌ 활동 추가 실패: \(error.localizedDescription)")
        }
    }
}

extension ResumeViewModel {
    
    
    // MARK: - Data Func
    
    func prepareCareerEdit(careerId: Int) {
        guard let career = careersList.first(where: { $0.careerId == careerId }) else {
            return
        }
        
        careerWriteModel = CareerWriteModel(
            startAt: career.startAt,
            endAt: career.endAt,
            name: career.name,
            place: career.place,
            description: career.description
        )
        
        isPeriodFilled = true
        selectCareerId = careerId
    }
    
    func selectCareer(id: Int) {
        selectCareerId = id
    }
}
