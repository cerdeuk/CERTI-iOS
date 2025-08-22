//
//  AuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/14/25.
//

import Foundation

protocol AuthRepository {
    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponseEntity, NetworkError>
    func signUp(request: SignupRequestDTO, preSignUpToken: String) async -> Result<SignupSuccessResponseDTO, NetworkError>
    func withDraw() async -> Result<Void, NetworkError>
}
