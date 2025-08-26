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
}
