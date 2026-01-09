//
//  DefaultAuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import Moya

final class DefaultAuthRepository: AuthRepository {

    private let service: AuthServiceProtocol

    public init(service: AuthServiceProtocol) {
        self.service = service
    }
        
    func withDraw() async -> Result<Void, NetworkError> {
        return await service.withDraw()
    }
    
    func login(type: String, accessToken: String) async -> Result<LoginResponseEntity, NetworkError> {
        let result = await service.login(type: type, accessToken: accessToken)
        
        switch result {
        case .success(let response):
            guard let data = response.data else { return .failure(.decodingError) }
            return .success(data.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func signUp(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupResponseEntity, NetworkError> {
        let requestDTO = SignupRequestDTO(
            userInformation: .init(
                socialID: request.userInformation.socialID,
                name: request.userInformation.name,
                socialType: request.userInformation.socialType,
                email: request.userInformation.email,
                profileImageURL: request.userInformation.profileImageURL
            ),
            university: request.university,
            grade: request.grade,
            track: request.track,
            major: request.major,
            nickname: request.nickname,
            jobs: request.jobs
        )
        
        let result = await service.signUp(request: requestDTO, preSignUpToken: preSignUpToken)
        
        switch result {
        case .success(let response):
            guard let data = response.data else { return .failure(.decodingError) }
            return .success(data.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }

}
