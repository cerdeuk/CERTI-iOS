//
//  UserRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/15/25.
//


import Foundation
import Moya

protocol UserRepository {
    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError>
}
