//
//  FetchAcquisitionListUseCase.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 8/16/25.
//

import Foundation

protocol FetchAcquisitionListUseCase {
    func execute() async -> Result<[CertificatedListModel], ResumeError>
}

struct FetchAcquisitionListUseCaseImpl: FetchAcquisitionListUseCase {
    private let repository: ResumeRepository
    init(repository: ResumeRepository) { self.repository = repository }

    func execute() async -> Result<[CertificatedListModel], ResumeError> {
        return await repository.fetchAcquisitionList()
    }
}
