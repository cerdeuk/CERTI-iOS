//
//  FetchMajorListUseCase.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/23/25.
//

import Foundation

protocol FetchMajorListUseCase {
    func execute(keyword: String, preSignUpToken: String) async -> Result<MajorListEntity, NetworkError>
}

final class DefaultFetchMajorListUseCase: FetchMajorListUseCase {
    
    private let repository: OnboardingRepository

    init(repository: OnboardingRepository) {
        self.repository = repository
    }

    func execute(keyword: String, preSignUpToken: String) async -> Result<MajorListEntity, NetworkError> {
        await repository.getSearchMajor(keyword: keyword, preSignUpToken: preSignUpToken)
    }
    
}
