//
//  ResumeFactory.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/22/25.
//

import Foundation

protocol ResumeFactory {
    @MainActor func makeResumeViewModel() -> ResumeViewModel
}

final class DefaultResumeFactory: ResumeFactory {
    let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    let fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    
    let addCareersUseCase: AddCareersUseCase
    let deleteCareersUseCase: DeleteCareersUseCase
    let fetchCareersListUseCase: FetchCareersListUseCase
    
    let addActivityUseCase: AddActivityUseCase
    let deleteActivityUseCase: DeleteActivityUseCase
    let fetchActivityListUseCase: FetchActivityListUseCase
    
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
    
    @MainActor
    func makeResumeViewModel() -> ResumeViewModel {
        ResumeViewModel(
            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
            fetchAcquisitionDetailUseCase: fetchAcquisitionDetailUseCase,
            deleteAcquisitionUseCase: deleteAcquisitionUseCase,
            addCareersUseCase: addCareersUseCase,
            deleteCareersUseCase: deleteCareersUseCase,
            fetchCareersListUseCase: fetchCareersListUseCase,
            addActivityUseCase: addActivityUseCase,
            deleteActivityUseCase: deleteActivityUseCase,
            fetchActivityListUseCase: fetchActivityListUseCase
        )
    }
}
