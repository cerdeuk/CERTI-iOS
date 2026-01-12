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
    let fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase
    
    init(
        fetchMyPageInfoUseCase: FetchMyPageInfoUseCase,
        fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase
    ) {
        self.fetchMyPageInfoUseCase = fetchMyPageInfoUseCase
        self.fetchEditProfileInfoUseCase = fetchEditProfileInfoUseCase
    }
    
    @MainActor
    func makeMyPageViewModel() -> MyPageViewModel {
        MyPageViewModel(
            fetchMyPageInfoUseCase: fetchMyPageInfoUseCase,
            fetchEditProfileInfoUseCase: fetchEditProfileInfoUseCase
        )
    }
}
