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
    private let editMajorUseCase: EditMajorUseCase
    private let editUnivUseCase: EditUnivUseCase
    private let getPreCertificationUseCase: GetPreCertificationUseCase
    private let getFavoriteCertificationUseCase: GetFavoriteCertificationUseCase
    private let withDrawUseCase: WithDrawUseCase
    private let getNotificationSettingUseCase: GetNotificationSettingUseCase
    private let toggleNotificationSettingUseCase: ToggleNotificationSettingUseCase
    
    init(
        fetchMyPageInfoUseCase: FetchMyPageInfoUseCase,
        fetchEditProfileInfoUseCase: FetchEditProfileInfoUseCase,
        checkNickNameUseCase: CheckNickNameUseCase,
        updateEditProfileInfoUseCase: UpdateEditProfileInfoUseCase,
        editJobUseCase: EditJobUseCase,
        fetchMajorListUseCase: FetchMyPageMajorListUseCase,
        fetchUnivListUseCase: FetchMyPageUnivListUseCase,
        editMajorUseCase: EditMajorUseCase,
        editUnivUseCase: EditUnivUseCase,
        getPreCertificationUseCase: GetPreCertificationUseCase,
        getFavoriteCertificationUseCase: GetFavoriteCertificationUseCase,
        withDrawUseCase: WithDrawUseCase,
        getNotificationSettingUseCase: GetNotificationSettingUseCase,
        toggleNotificationSettingUseCase: ToggleNotificationSettingUseCase
    ) {
        self.fetchMyPageInfoUseCase = fetchMyPageInfoUseCase
        self.fetchEditProfileInfoUseCase = fetchEditProfileInfoUseCase
        self.checkNickNameUseCase = checkNickNameUseCase
        self.updateEditProfileInfoUseCase = updateEditProfileInfoUseCase
        self.editJobUseCase = editJobUseCase
        self.fetchMajorListUseCase = fetchMajorListUseCase
        self.fetchUnivListUseCase = fetchUnivListUseCase
        self.editMajorUseCase = editMajorUseCase
        self.editUnivUseCase = editUnivUseCase
        self.getPreCertificationUseCase = getPreCertificationUseCase
        self.getFavoriteCertificationUseCase = getFavoriteCertificationUseCase
        self.withDrawUseCase = withDrawUseCase
        self.getNotificationSettingUseCase = getNotificationSettingUseCase
        self.toggleNotificationSettingUseCase = toggleNotificationSettingUseCase
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
            fetchUnivListUseCase: fetchUnivListUseCase,
            editMajorUseCase: editMajorUseCase,
            editUnivUseCase: editUnivUseCase,
            getPreCertificationsUseCase: getPreCertificationUseCase,
            getFavoriteCertificationsUseCase: getFavoriteCertificationUseCase,
            withDrawUseCase: withDrawUseCase,
            getNotificationSettingUseCase: getNotificationSettingUseCase,
            toggleNotificationSettingUseCase: toggleNotificationSettingUseCase
        )
    }
}
