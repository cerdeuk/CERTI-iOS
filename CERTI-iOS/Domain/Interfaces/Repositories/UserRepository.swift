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
}
