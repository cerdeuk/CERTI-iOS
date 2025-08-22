//
//  FetchUnivListUsecase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/23/25.
//

import Foundation

protocol FetchUnivListUseCase {
    func execute(keyword: String, preSignUpToken: String) async -> Result<UniversityListEntity, NetworkError>
}

final class DefaultFetchUnivListUseCase: FetchUnivListUseCase {
    
    private let repository: OnboardingRepository

    init(repository: OnboardingRepository) {
        self.repository = repository
    }

    func execute(keyword: String, preSignUpToken: String) async -> Result<UniversityListEntity, NetworkError> {
        await repository.getSearchUniv(keyword: keyword, preSignUpToken: preSignUpToken)
    }
    
}
