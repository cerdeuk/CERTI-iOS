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
    let signupUseCase: SignUpUseCase
    let checkNickNameUseCase: CheckNickNameUseCase

    init(
        fetchMajorListUseCase: FetchMajorListUseCase,
        fetchUnivListUseCase: FetchUnivListUseCase,
        signupUseCase: SignUpUseCase,
        checkNickNameUseCase: CheckNickNameUseCase
    ) {
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
        self.signupUseCase = signupUseCase
        self.checkNickNameUseCase = checkNickNameUseCase
    }

    @MainActor
    func makeOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(
            fetchMajorListUseCase: fetchMajorListUseCase,
            fetchUnivListUseCase: fetchUnivListUseCase,
            signupUseCase: signupUseCase,
            checkNickNameUseCase: checkNickNameUseCase
        )
    }
}
