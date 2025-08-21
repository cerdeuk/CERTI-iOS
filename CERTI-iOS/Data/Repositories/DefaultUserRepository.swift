//
//  DefaultUserRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/15/25.
//

import Foundation

import Moya

final class DefaultUserRepository: UserRepository {

    private let service: UserServiceProtocol

    public init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func getUserInfo() async -> Result<UserInfoEntity, NetworkError> {
        let result = await service.getuserInfo()
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
