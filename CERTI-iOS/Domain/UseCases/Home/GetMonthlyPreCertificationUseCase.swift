//
//  GetMonthlyPreCertificationUseCase.swift
//  CERTI-iOS
//
//  Created by nayeon on 1/30/26.
//

protocol GetMonthlyPreCertificationUseCase {
    func execute(year: Int, month: Int) async -> Result<MonthlyPreCertificationEntity, NetworkError>
}

final class DefaultGetMonthlyPreCertificationUseCase: GetMonthlyPreCertificationUseCase {
    
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func execute(year: Int, month: Int) async -> Result<MonthlyPreCertificationEntity, NetworkError> {
        await repository.getMonthlyPreCertification(year: year, month: month)
    }
    
}
