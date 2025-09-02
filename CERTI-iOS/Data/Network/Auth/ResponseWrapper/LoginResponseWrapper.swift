//
//  LoginResponseWrapper.swift
//  CERTI-iOS
//
//  Created by OneTen on 9/2/25.
//

import Foundation

struct LoginResponseWrapper: Decodable {
    let needSignUp: Bool
    let loginSuccess: LoginSuccessResponseDTO?
    let signupRequired: SignupRequiredResponseDTO?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.needSignUp = try container.decode(Bool.self, forKey: .needSignUp)

        if needSignUp {
            self.signupRequired = try SignupRequiredResponseDTO(from: decoder)
            self.loginSuccess = nil
        } else {
            self.loginSuccess = try LoginSuccessResponseDTO(from: decoder)
            self.signupRequired = nil
        }
    }

    private enum CodingKeys: String, CodingKey {
        case needSignUp
    }
}
