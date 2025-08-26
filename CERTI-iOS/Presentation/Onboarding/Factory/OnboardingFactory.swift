//
//  OnboardingFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/23/25.
//

import SwiftUI

protocol OnboardingFactory {
    @MainActor func makeOnboardingViewModel() -> OnboardingViewModel
}

final class DefaultOnboardingFactory: OnboardingFactory {
    let fetchMajorListUseCase: FetchMajorListUseCase
    let fetchUnivListUseCase: FetchUnivListUseCase

    init(
        fetchMajorListUseCase: FetchMajorListUseCase,
        fetchUnivListUseCase: FetchUnivListUseCase
    ) {
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
    }

    @MainActor
    func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(
            fetchMajorListUseCase: fetchMajorListUseCase,
            fetchUnivListUseCase: fetchUnivListUseCase
        )
    }
}
