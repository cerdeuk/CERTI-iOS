//
//  DefaultAuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import Foundation

import Moya

enum AuthResponseEntity {
    case success(LoginSuccessResponseEntity)
    case needSignUp(SignupRequiredResponseEntity)
}

final class DefaultAuthRepository: AuthRepository {
    
    private let service: AuthServiceProtocol

    public init(service: AuthServiceProtocol) {
        self.service = service
    }
        
    func withDraw() async -> Result<Void, NetworkError> {
        return await service.withDraw()
    }
    
    func signUp(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupSuccessUserDataEntity, NetworkError> {
        let result = await service.signUp(request: request.toSignupRequestDTO(), preSignUpToken: preSignUpToken)
        
        switch result {
        case .success(let dto):
            guard let entity = dto.data?.toSignupSuccessUserDataEntity() else {
                return .failure(.decodingError)
            }
            return .success(entity)
        case .failure(let error):
            return .failure(error)
        }
    }
    

    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponseEntity, NetworkError> {
        let result = await service.login(type: type, authorizationCode: authorizationCode)

        switch result {
        case .success(let dto):
            switch dto {
            case .success(let loginDTO):
                let entity = LoginSuccessResponseEntity(userId: loginDTO.userId, nickName: loginDTO.nickName, needSignUp: loginDTO.needSignUp, tokenResponseData: loginDTO.tokenResponse?.toTokenResponseData())
                return .success(.success(entity))
            case .needSignUp(let signupDTO):
                let entity = SignupRequiredResponseEntity(needSignUp: signupDTO.needSignUp, preSignupToken: signupDTO.preSignupToken, userInformation: signupDTO.userInformation.toUserInformationEntityData())
                return .success(.needSignUp(entity))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
