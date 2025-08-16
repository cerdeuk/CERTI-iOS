//
//  ResumeViewModelFactory.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

final class ResumeViewModelFactory {
    @MainActor
    static func make() -> ResumeViewModel {
        let repository = ResumeRepositoryImpl(
            careersService: CareersService(),
            activityService: ActivityService(),
            acquisitionService: AcquisitionService(),
            jobService: JobService()
        )
        // 모든 UseCase 생성
        let fetchJobsUseCase = FetchJobsUseCaseImpl(repository: repository)
//        let fetchAcquisitionListUseCase = FetchAcquisitionListUseCaseImpl(repository: repository)
//        let fetchAcquisitionDetailUseCase = FetchAcquisitionDetailUseCaseImpl(repository: repository)
//        let fetchCareersListUseCase = FetchCareersListUseCaseImpl(repository: repository)
//        let addCareerUseCase = AddCareerUseCaseImpl(repository: repository)
//        let deleteAcquisitionUseCase = DeleteAcquisitionUseCaseImpl(repository: repository)
//        let deleteCareerUseCase = DeleteCareerUseCaseImpl(repository: repository)
//        let fetchActivityListUseCase = FetchActivityListUseCaseImpl(repository: repository)
//        let addActivityUseCase = AddActivityUseCaseImpl(repository: repository)
//        let deleteActivityUseCase = DeleteActivityUseCaseImpl(repository: repository)

        // ViewModel에 모두 주입
        return ResumeViewModel(
            fetchJobsUseCase: fetchJobsUseCase,
//            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
//            fetchAcquisitionDetailUseCase: fetchAcquisitionDetailUseCase,
//            deleteAcquisitionUseCase: deleteAcquisitionUseCase,
//            fetchCareersListUseCase: fetchCareersListUseCase,
//            addCareerUseCase: addCareerUseCase,
//            deleteCareerUseCase: deleteCareerUseCase,
//            fetchActivityListUseCase: fetchActivityListUseCase,
//            addActivityUseCase: addActivityUseCase,
//            deleteActivityUseCase: deleteActivityUseCase
        )
    }
}
