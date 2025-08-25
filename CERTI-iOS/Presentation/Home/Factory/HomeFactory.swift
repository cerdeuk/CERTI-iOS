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
    let withDrawUseCase: WithDrawUseCase

    init(
        addPreUseCase: AddPreCertificationUseCase,
        deletePreUseCase: DeletePreCertificationUseCase,
        getPreUseCase: GetPreCertificationUseCase,
        getFavoriteUseCase: GetFavoriteCertificationUseCase,
        fetchUserInfoUseCase: FetchUserInfoUseCase,
        withDrawUseCase: WithDrawUseCase
    ) {
        self.addPreUseCase = addPreUseCase
        self.deletePreUseCase = deletePreUseCase
        self.getPreUseCase = getPreUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.withDrawUseCase = withDrawUseCase
    }

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            addPreCertificationUseCase: addPreUseCase,
            deletePreCertificationUseCase: deletePreUseCase,
            getPreCertificationsUseCase: getPreUseCase,
            getFavoriteCertificationsUseCase: getFavoriteUseCase,
            fetchUserInfoUseCase: fetchUserInfoUseCase,
            withDrawUseCase: withDrawUseCase
        )
    }
}
