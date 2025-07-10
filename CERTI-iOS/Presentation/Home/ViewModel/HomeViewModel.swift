//
//  HomeViewModel.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

// 뷰모델 사용 예시를 보여주기 위한 임시 모델
struct HomeStateModel {
    var username: String = "김서티22"
    var userUniversity: String = "솝트대학교"
    var userDepartment: String = "서티취득학과"
    var progressValue: Int = 30

    var recommendLicenses: [RecommendLicenseCardModel] = RecommendLicenseCardModel.dummy()
    var preLicenses: [PreLicenseCardModel] = PreLicenseCardModel.dummy()
    var favoriteLicenses: [FavoriteLicenseCardModel] = FavoriteLicenseCardModel.dummy()
}

final class HomeViewModel: ObservableObject {
    @Published var homewStateModel = HomeStateModel()
}
