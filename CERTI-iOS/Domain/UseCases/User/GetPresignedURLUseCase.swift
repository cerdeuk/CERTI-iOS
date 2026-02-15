//
//  GetPresignedURLUseCase.swift
//  CERTI-iOS
//
//  Created by nayeon on 2/14/26.
//

protocol GetPresignedURLUseCase {
    func execute() async -> Result<PresignedURLEntity, NetworkError>
}

final class DefaultGetPresignedURLUseCase: GetPresignedURLUseCase {
    
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<PresignedURLEntity, NetworkError> {
        return await repository.getPresignedURL()
    }
}
