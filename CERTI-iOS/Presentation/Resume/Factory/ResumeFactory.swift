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
    
    init(
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase,
        DeleteAcquisitionUseCase: DeleteAcquisitionUseCase
    ) {
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.fetchAcquisitionDetailUseCase = fetchAcquisitionDetailUseCase
        self.deleteAcquisitionUseCase = DeleteAcquisitionUseCase
    }
    
    @MainActor
    func makeResumeViewModel() -> ResumeViewModel {
        ResumeViewModel(
            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
            fetchAcquisitionDetailUseCase: fetchAcquisitionDetailUseCase,
            deleteAcquisitionUseCase: deleteAcquisitionUseCase
        )
    }
}
