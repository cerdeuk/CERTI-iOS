//
//  CategoryFactory.swift
//  CERTI-iOS
//
//  Created by 김나연 on 8/24/25.
//

import SwiftUI

protocol CategoryFactory {
    @MainActor func makeCategoryViewModel() -> CategoryViewModel
}

final class DefaultCategoryFactory: CategoryFactory {
    let fetchCategoryUseCase: FetchCategoryUseCase
    let switchFavoriteUseCase: SwitchFavoriteUseCase
    let searchCertificationUseCase: SearchCertificationUseCase
    
    init(
        fetchCategoryUseCase: FetchCategoryUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        searchCertificationUseCase: SearchCertificationUseCase
    ) {
        self.fetchCategoryUseCase = fetchCategoryUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.searchCertificationUseCase = searchCertificationUseCase
    }
    
    @MainActor
    func makeCategoryViewModel() -> CategoryViewModel {
        CategoryViewModel(
            fetchCategoryUseCase: fetchCategoryUseCase,
            switchFavoriteUseCase: switchFavoriteUseCase,
            searchCertificationUseCase: searchCertificationUseCase
        )
    }
}

