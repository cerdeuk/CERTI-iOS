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
            guard let entity = dto.data?.toUserInfoEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func checkNickName(nickname: String) async -> Result<String, NetworkError> {
        let result = await service.checkNickName(nickname: nickname)
        
        switch result {
        case .success(let response):
            return .success(response.message)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getMyPageInfo() async -> Result<MyPageEntity, NetworkError> {
        let result = await service.getMyPageInfo()
        
        switch result {
        case .success(let response):
            guard let entity = response.data?.toMyPageEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getEditProfileInfo() async -> Result<EditProfileEntity, NetworkError> {
        let result = await service.getEditProfileInfo()
        
        switch result {
        case .success(let response):
            guard let entity = response.data?.toEditProfileEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
}
