//
//  UserRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol UserRepository {
    func getUserInfo() async -> Result<UserInfoEntity, NetworkError>
    func checkNickName(nickname: String) async -> Result<String, NetworkError>
    func getMyPageInfo() async -> Result<MyPageEntity, NetworkError>
    func getEditProfileInfo() async -> Result<EditProfileEntity, NetworkError>
    func putEditProfileInfo(profileInfo: EditProfileEntity) async -> Result<Void, NetworkError>
    func getSearchUniv(keyword: String) async -> Result<UniversityListEntity, NetworkError>
    func getSearchMajor(keyword: String) async -> Result<MajorListEntity, NetworkError>
    func editUniv(request: String) async -> Result<Void, NetworkError>
    func editMajor(request: String) async -> Result<Void, NetworkError>
    func getNotificationSetting() async -> Result<UserAgreementEntity, NetworkError>
    func toggleMarketingSetting(agree: Bool) async -> Result<Void, NetworkError>
    func togglePrivacySetting(agree: Bool) async -> Result<Void, NetworkError>
    func getTrack() async -> Result<String, NetworkError>
}
