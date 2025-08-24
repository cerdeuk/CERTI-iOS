//
//  FetchJobUseCase.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/21/25.
//

protocol FetchJobUseCase {
    func execute() async -> Result<JobEntity, NetworkError>
}

final class DefaultFetchJobUseCase: FetchJobUseCase {
    private let repository: JobRepository
    
    init(repository: JobRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<JobEntity, NetworkError> {
        return await repository.getFetchJob()
    }
}
