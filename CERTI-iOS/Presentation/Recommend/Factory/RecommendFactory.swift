//
//  RecommendFactory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import SwiftUI

protocol RecommendFactory {
    @MainActor func makeRecommendViewModel() -> RecommendViewModel
}

final class DefaultRecommendFactory: RecommendFactory {
    let fetchRecommendUseCase: FetchRecommendUseCase
    let switchFavoriteUseCase: SwitchFavoriteUseCase
    let fetchJobUseCase: FetchJobUseCase
    let editJobUseCase: EditJobUseCase
    
    init(
        fetchRecommendUseCase: FetchRecommendUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchJobUseCase: FetchJobUseCase,
        editJobUseCase: EditJobUseCase
    ) {
        self.fetchRecommendUseCase = fetchRecommendUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchJobUseCase = fetchJobUseCase
        self.editJobUseCase = editJobUseCase
    }
    
    @MainActor
    func makeRecommendViewModel() -> RecommendViewModel {
        RecommendViewModel(
            fetchRecommendUseCase: fetchRecommendUseCase,
            switchFavoriteUseCase: switchFavoriteUseCase,
            fetchJobUseCase: fetchJobUseCase,
            editJobUseCase: editJobUseCase
        )
    }
}
