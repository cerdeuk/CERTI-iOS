//
//  GetDailyPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

protocol GetDailyPreCertificationUseCase {
    func execute(date: String) async -> Result<DailyPreCertificationEntity, NetworkError>
}

final class DefaultGetDailyPreCertificationUseCase: GetDailyPreCertificationUseCase {
    
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func execute(date: String) async -> Result<DailyPreCertificationEntity, NetworkError> {
        await repository.getDailyPreCertification(date: date)
    }
    
}
