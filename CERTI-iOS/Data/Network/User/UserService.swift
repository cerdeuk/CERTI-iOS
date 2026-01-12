//
//  UserService.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

protocol UserServiceProtocol {
    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError>
    func checkNickName(nickname: String) async -> Result<BaseResponseDTO<EmptyData>, NetworkError>
    func getMyPageInfo() async -> Result<MyPageResponseDTO, NetworkError>
}

final class UserService: BaseService, UserServiceProtocol {
    
    private let provider = MoyaProvider<UserAPI>.init(plugins: [MoyaPlugin()])

    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getUserInfo)
    }
    
    func checkNickName(nickname: String) async -> Result<BaseResponseDTO<EmptyData>, NetworkError> {
        return await requestDecodable(provider, .checkNickname(nickname: nickname))
    }
    
    func getMyPageInfo() async -> Result<MyPageResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getMyPageInfo)
    }
}
