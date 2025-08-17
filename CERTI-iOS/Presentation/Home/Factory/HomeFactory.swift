//
//  HomeFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/17/25.
//

import SwiftUI

protocol HomeFactory {
    @MainActor func makeHomeViewModel() -> HomeViewModel
}

final class DefaultHomeFactory: HomeFactory {
    
    private let container: AppDIContainer
    
    init(container: AppDIContainer) {
        self.container = container
    }
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            addPreCertificationUseCase: container.makeAddPreCertificationUseCase(),
            deletePreCertificationUseCase: container.makeDeletePreCertificationUseCase(),
            getPreCertificationsUseCase: container.makeGetPreCertificationUseCase(),
            getFavoriteCertificationsUseCase: container.makeGetFavoritePreCertificationUseCase()
        )
    }
}
