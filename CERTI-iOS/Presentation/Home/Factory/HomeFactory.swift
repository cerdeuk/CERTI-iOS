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
    let deletePreUseCase: DeletePreCertificationUseCase
    let getPreUseCase: GetPreCertificationUseCase
    let getFavoriteUseCase: GetFavoriteCertificationUseCase
    let fetchUserInfoUseCase: FetchUserInfoUseCase
    let withDrawUseCase: WithDrawUseCase
    let switchFavoriteUseCase: SwitchFavoriteUseCase
    let fetchRecommendUseCase: FetchRecommendUseCase

    init(
        deletePreUseCase: DeletePreCertificationUseCase,
        getPreUseCase: GetPreCertificationUseCase,
        getFavoriteUseCase: GetFavoriteCertificationUseCase,
        fetchUserInfoUseCase: FetchUserInfoUseCase,
        withDrawUseCase: WithDrawUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchRecommendUseCase: FetchRecommendUseCase
    ) {
        self.deletePreUseCase = deletePreUseCase
        self.getPreUseCase = getPreUseCase
        self.getFavoriteUseCase = getFavoriteUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.withDrawUseCase = withDrawUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchRecommendUseCase = fetchRecommendUseCase
    }

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            deletePreCertificationUseCase: deletePreUseCase,
            getPreCertificationsUseCase: getPreUseCase,
            getFavoriteCertificationsUseCase: getFavoriteUseCase,
            fetchUserInfoUseCase: fetchUserInfoUseCase,
            withDrawUseCase: withDrawUseCase,
            switchFavoriteUseCase: switchFavoriteUseCase,
            fetchRecommendUseCase: fetchRecommendUseCase
        )
    }
}
