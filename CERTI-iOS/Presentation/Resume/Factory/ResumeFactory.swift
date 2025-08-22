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
    
    init(
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        fetchAcquisitionDetailUseCase: FetchAcquisitionDetailUseCase
    ) {
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.fetchAcquisitionDetailUseCase = fetchAcquisitionDetailUseCase
    }
    
    @MainActor
    func makeResumeViewModel() -> ResumeViewModel {
        ResumeViewModel(
            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
            fetchAcquisitionDetailUseCase: fetchAcquisitionDetailUseCase
        )
    }
}
