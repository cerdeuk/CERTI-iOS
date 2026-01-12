//
//  MyPageFactory.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

protocol MyPageFactory {
    @MainActor func makeMyPageViewModel() -> MyPageViewModel
}

final class DefaultMyPageFactory: MyPageFactory {
    let fetchMyPageInfoUseCase: FetchMyPageInfoUseCase
    
    init(fetchMyPageInfoUseCase: FetchMyPageInfoUseCase) {
        self.fetchMyPageInfoUseCase = fetchMyPageInfoUseCase
    }
    
    @MainActor
    func makeMyPageViewModel() -> MyPageViewModel {
        MyPageViewModel(fetchMyPageInfoUseCase: fetchMyPageInfoUseCase)
    }
}
