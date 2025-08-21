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
    let fetchUserInfoUseCase: FetchUserInfoUseCase

    init(
        addPreUseCase: AddPreCertificationUseCase,
        deletePreUseCase: DeletePreCertificationUseCase,
        getPreUseCase: GetPreCertificationUseCase,
        getFavoriteUseCase: GetFavoriteCertificationUseCase,
        fetchUserInfoUseCase: FetchUserInfoUseCase
    ) {
        self.addPreUseCase = addPreUseCase
        self.deletePreUseCase = deletePreUseCase
        self.getPreUseCase = getPreUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            addPreCertificationUseCase: addPreUseCase,
            deletePreCertificationUseCase: deletePreUseCase,
            getPreCertificationsUseCase: getPreUseCase,
            getFavoriteCertificationsUseCase: getFavoriteUseCase,
            fetchUserInfoUseCase: fetchUserInfoUseCase
        )
    }
}
