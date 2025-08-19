//
//  DefaultUserRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

final class DefaultUserRepository:  UserRepository {
    
    private let service: UserServiceProtocol

    public init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func getuserInfo() async -> Result<UserInfoResponseDTO, NetworkError> {
        return await service.getuserInfo()
    }
    
}
