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
    let addPreUseCase: AddPreCertificationUseCase
    let deletePreUseCase: DeletePreCertificationUseCase
    let getPreUseCase: GetPreCertificationUseCase
    let getFavoriteUseCase: GetFavoriteCertificationUseCase

    init(
        addPreUseCase: AddPreCertificationUseCase,
        deletePreUseCase: DeletePreCertificationUseCase,
        getPreUseCase: GetPreCertificationUseCase,
        getFavoriteUseCase: GetFavoriteCertificationUseCase
    ) {
        self.addPreUseCase = addPreUseCase
        self.deletePreUseCase = deletePreUseCase
        self.getPreUseCase = getPreUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
    }

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            addPreCertificationUseCase: addPreUseCase,
            deletePreCertificationUseCase: deletePreUseCase,
            getPreCertificationsUseCase: getPreUseCase,
            getFavoriteCertificationsUseCase: getFavoriteUseCase
        )
    }
}
