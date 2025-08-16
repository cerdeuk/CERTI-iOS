//
//  ResumeViewModel.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/14/25.
//

import Foundation

@MainActor
final class ResumeViewModel: ObservableObject {
    // MARK: - UI 상태

    @Published var careerDummy: [ResumeModel] = ResumeModel.myCareerDummy()
    @Published var myExtracurricularActivityModelDummy: [ResumeModel] = ResumeModel.myExtracurricularActivityDummy()
    @Published var certificatedDummy: [CertificatedListModel] = CertificatedListModel.dummy()

    @Published var jobList: [String] = []
    @Published var acquisitionList: [CertificatedListModel] = []
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

    // MARK: - Derived State

    var isWriteButtonEnabled: Bool {
        !resumeModel.name.isBlank &&
        !resumeModel.place.isBlank &&
        !resumeModel.discription.isBlank &&
        isPeriodFilled
    }

    // MARK: - UseCase 주입

    private let fetchJobsUseCase: FetchJobsUseCase
    private let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    private let fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    private let deleteAcquisitionUseCase: DeleteAcquisitionUseCase

    private let fetchCareersUseCase: FetchCareersUseCase
    private let addCareerUseCase: AddCareerUseCase
    private let deleteCareerUseCase: DeleteCareerUseCase

    private let fetchActivitiesUseCase: FetchActivitiesUseCase
    private let addActivityUseCase: AddActivityUseCase
    private let deleteActivityUseCase: DeleteActivityUseCase

    // MARK: - Init

    init(
        fetchJobsUseCase: FetchJobsUseCase,
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase,
        deleteAcquisitionUseCase: DeleteAcquisitionUseCase,
        fetchCareersUseCase: FetchCareersUseCase,
        addCareerUseCase: AddCareerUseCase,
        deleteCareerUseCase: DeleteCareerUseCase,
        fetchActivitiesUseCase: FetchActivitiesUseCase,
        addActivityUseCase: AddActivityUseCase,
        deleteActivityUseCase: DeleteActivityUseCase
    ) {
        self.fetchJobsUseCase = fetchJobsUseCase
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.fetchAcquisitionDetailUseCase = fetchAcquisitionDetailUseCase
        self.deleteAcquisitionUseCase = deleteAcquisitionUseCase
        self.fetchCareersUseCase = fetchCareersUseCase
        self.addCareerUseCase = addCareerUseCase
        self.deleteCareerUseCase = deleteCareerUseCase
        self.fetchActivitiesUseCase = fetchActivitiesUseCase
        self.addActivityUseCase = addActivityUseCase
        self.deleteActivityUseCase = deleteActivityUseCase
    }

    // MARK: - 상태 초기화

    func clearResumeModel() {
        resumeModel = ResumeModel(startAt: "", endAt: "", name: "", place: "", discription: "")
        isPeriodFilled = false
    }

    // MARK: - 상태 변경 요청 함수 (비즈니스 로직 없음)

    func loadJobs(_ jobs: [String]) {
        self.jobList = jobs
    }

    func loadAcquisitionList(_ list: [CertificatedListModel]) {
        self.acquisitionList = list
    }

    func loadAcquisitionDetail(_ detail: CertificatedDetailModel?) {
        self.acquisitionDetail = detail
    }

    func removeAcquisition(by id: Int) {
        acquisitionList.removeAll { $0.acquisitionId == id }
    }

    func loadCareers(_ list: [ResumeModel]) {
        self.careersList = list
    }

    func removeCareer(by id: Int) {
        careersList.removeAll { $0.careerId == id }
    }

    func loadActivities(_ list: [ResumeModel]) {
        self.activityList = list
    }

    func removeActivity(by id: Int) {
        activityList.removeAll { $0.activityId == id }
    }
}
