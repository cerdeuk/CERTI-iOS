//
//  EditJobUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/21/25.
//

import Foundation

protocol EditJobUseCase {
    func execute(jobNameList: [String]) async -> Result<Void, NetworkError>
}

final class DefaultEditJobUseCase: EditJobUseCase {
    private let repository: JobRepository
    
    init(repository: JobRepository) {
        self.repository = repository
    }
    
    func execute(jobNameList: [String]) async -> Result<Void, NetworkError> {
        let result = await repository.editJob(jobNameList: jobNameList)
        return result
    }
}
