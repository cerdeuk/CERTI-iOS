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
    private let toggleMarketingSettingUseCase: ToggleMarketingSettingUseCase
    private let togglePrivacySettingUseCase: TogglePrivacySettingUseCase
    private let switchFavoriteUseCase: SwitchFavoriteUseCase
    private let fetchAcquisitionListUseCase: FetchAcquisitionListUseCase
    private let deleteAcquisitionUseCase: DeleteAcquisitionUseCase
    private let deletePreCertificationUseCase: DeletePreCertificationUseCase
    private let editAcquisitionUseCase: EditAcquisitionUseCase
    private let editPreCertificationUseCase: EditPreCertificationUseCase
    
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
        toggleMarketingSettingUseCase: ToggleMarketingSettingUseCase,
        togglePrivacySettingUseCase: TogglePrivacySettingUseCase,
        switchFavoriteUseCase: SwitchFavoriteUseCase,
        fetchAcquisitionListUseCase: FetchAcquisitionListUseCase,
        deleteAcquisitionUseCase: DeleteAcquisitionUseCase,
        deletePreCertificationUseCase: DeletePreCertificationUseCase,
        editAcquisitionUseCase: EditAcquisitionUseCase,
        editPreCertificationUseCase: EditPreCertificationUseCase,
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
        self.toggleMarketingSettingUseCase = toggleMarketingSettingUseCase
        self.togglePrivacySettingUseCase = togglePrivacySettingUseCase
        self.switchFavoriteUseCase = switchFavoriteUseCase
        self.fetchAcquisitionListUseCase = fetchAcquisitionListUseCase
        self.deleteAcquisitionUseCase = deleteAcquisitionUseCase
        self.deletePreCertificationUseCase = deletePreCertificationUseCase
        self.editAcquisitionUseCase = editAcquisitionUseCase
        self.editPreCertificationUseCase = editPreCertificationUseCase
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
            toggleMarketingSettingUseCase: toggleMarketingSettingUseCase,
            togglePrivacySettingUseCase: togglePrivacySettingUseCase,
            switchFavoriteUseCase: switchFavoriteUseCase,
            fetchAcquisitionListUseCase: fetchAcquisitionListUseCase,
            deleteAcquisitionUseCase: deleteAcquisitionUseCase,
            deletePreCertificationUseCase: deletePreCertificationUseCase,
            editAcquisitionUseCase: editAcquisitionUseCase,
            editPreCertificationUseCase: editPreCertificationUseCase
        )
    }
}
