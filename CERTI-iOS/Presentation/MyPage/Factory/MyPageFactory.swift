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
    private let fetchMyPageInfoUseCase: FetchMyPageInfoUseCase
    private let fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase
    private let checkNickNameUseCase: CheckNickNameUseCase
    private let updateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase
    private let editJobUseCase: EditJobUseCase
    private let fetchMajorListUseCase: FetchMyPageMajorListUseCase
    private let fetchUnivListUseCase: FetchMyPageUnivListUseCase
    
    init(
        fetchMyPageInfoUseCase: FetchMyPageInfoUseCase,
        fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase,
        checkNickNameUseCase: CheckNickNameUseCase,
        updateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase,
        editJobUseCase: EditJobUseCase,
        fetchMajorListUseCase: FetchMyPageMajorListUseCase,
        fetchUnivListUseCase: FetchMyPageUnivListUseCase,
    ) {
        self.fetchMyPageInfoUseCase = fetchMyPageInfoUseCase
        self.fetchEditProfileInfoUseCase = fetchEditProfileInfoUseCase
        self.checkNickNameUseCase = checkNickNameUseCase
        self.updateEditProfileInfoUseCase = updateEditProfileInfoUseCase
        self.editJobUseCase = editJobUseCase
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
    }
    
    @MainActor
    func makeMyPageViewModel() -> MyPageViewModel {
        MyPageViewModel(
            fetchMyPageInfoUseCase: fetchMyPageInfoUseCase,
            fetchEditProfileInfoUseCase: fetchEditProfileInfoUseCase,
            checkNickNameUseCase: checkNickNameUseCase,
            updateEditProfileInfoUseCase: updateEditProfileInfoUseCase,
            editJobUseCase: editJobUseCase,
            fetchMajorListUseCase: fetchMajorListUseCase,
            fetchUnivListUseCase: fetchUnivListUseCase
        )
    }
}
