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
}

final class UserService: BaseService, UserServiceProtocol {
    
    private let provider = MoyaProvider<UserAPI>.init(plugins: [MoyaPlugin()])

    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError> {
        return await requestDecodable(provider, .getUserInfo)
    }
    
}
