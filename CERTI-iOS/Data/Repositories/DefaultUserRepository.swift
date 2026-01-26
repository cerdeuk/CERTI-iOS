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
    
    func putEditProfileInfo(profileInfo: EditProfileEntity) async -> Result<Void, NetworkError> {
        let dto = EditProfileRequestDTO(entity: profileInfo)
        let result = await service.putEditProfileInfo(profileInfo: dto)
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getSearchUniv(keyword: String) async -> Result<UniversityListEntity, NetworkError> {
        let result = await service.getSearchUniv(keyword: keyword)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toUniversityListEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    func getSearchMajor(keyword: String) async -> Result<MajorListEntity, NetworkError> {
        let result = await service.getSearchMajor(keyword: keyword)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toMajorListEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    func editUniv(request: String) async -> Result<Void, NetworkError> {
        let dto = EditUnivRequestDTO(universityName: request)
        let result = await service.editUniv(request: dto)
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func editMajor(request: String) async -> Result<Void, NetworkError> {
        let dto = EditMajorRequestDTO(majorName: request)
        let result = await service.editMajor(request: dto)
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getNotificationSetting() async -> Result<Bool, NetworkError> {
        let result = await service.getNotificationSetting()
        
        switch result {
        case .success(let response):
            return .success(response.data!.isAdAgreed)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func toggleNotificationSetting() async -> Result<Void, NetworkError> {
        let result = await service.toggleNotificationSetting()
        
        switch result {
        case .success(let success):
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
}
