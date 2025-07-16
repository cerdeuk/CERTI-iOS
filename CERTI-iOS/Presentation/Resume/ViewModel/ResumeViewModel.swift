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
}
