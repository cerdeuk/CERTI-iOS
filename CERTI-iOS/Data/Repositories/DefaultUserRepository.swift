//
//  DefaultUserRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

final class DefaultUserRepository: BaseService<UserAPI>, UserRepository {
    
    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError> {
        return await requestDecodable(.getUserInfo)
    }
    
}
