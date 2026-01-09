//
//  AuthRepository.swift
//  CERTI-iOS
//
//  Created by OneTen on 8/14/25.
//

import Foundation

protocol AuthRepository {
    func login(type: String, accessToken: String) async -> Result<LoginResponseEntity, NetworkError>
    func signUp(request: SignupRequestEntity, preSignUpToken: String) async -> Result<SignupResponseEntity, NetworkError>
    func withDraw() async -> Result<Void, NetworkError>
}
