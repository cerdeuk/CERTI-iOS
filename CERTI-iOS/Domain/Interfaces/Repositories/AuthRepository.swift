//
//  AuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/14/25.
//

import Foundation

protocol AuthRepository {
    func login(type: SocialLoginType, authorizationCode: String) async -> Result<AuthResponseEntity, NetworkError>
    func signUp(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupSuccessUserDataEntity, NetworkError>
    func withDraw() async -> Result<Void, NetworkError>
}
