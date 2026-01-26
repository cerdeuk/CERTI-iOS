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
    let fetchJobUseCase: FetchJobUseCase
    
    let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    let fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    
    let addCareersUseCase: AddCareersUseCase
    let deleteCareersUseCase: DeleteCareersUseCase
    let fetchCareersListUseCase: FetchCareersListUseCase
    let editCareerUseCase: EditCareersUseCase
    
    let addActivityUseCase: AddActivityUseCase
    let deleteActivityUseCase: DeleteActivityUseCase
    let fetchActivityListUseCase: FetchActivityListUseCase
    let editActivityUseCase: EditActivityUseCase
    
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
        fetchActivityListUseCase: FetchActivityListUseCase,
        editActivityUseCase: EditActivityUseCase
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
        self.editActivityUseCase = editActivityUseCase
    }
    
    @MainActor
    func makeResumeViewModel() -> ResumeViewModel {
        ResumeViewModel(
            fetchJobUseCase: fetchJobUseCase,
            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
            fetchAcquisitionDetailUseCase: fetchAcquisitionDetailUseCase,
            deleteAcquisitionUseCase: deleteAcquisitionUseCase,
            addCareersUseCase: addCareersUseCase,
            deleteCareersUseCase: deleteCareersUseCase,
            fetchCareersListUseCase: fetchCareersListUseCase,
            editCareerUseCase: editCareerUseCase,
            addActivityUseCase: addActivityUseCase,
            deleteActivityUseCase: deleteActivityUseCase,
            fetchActivityListUseCase: fetchActivityListUseCase,
            editActivityUseCase: editActivityUseCase
        )
    }
}
