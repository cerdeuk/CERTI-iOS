//
//  SignupRequiredResponseDTO.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/11/25.
//

struct SignupRequiredResponseDTO: Decodable {
    let needSignUp: Bool
    let preSignupToken: String
    let userInformation: UserInformation
    
    func toSignupRequiredResponseEntity() -> SignupRequiredResponseEntity {
        return SignupRequiredResponseEntity(
            needSignUp: needSignUp,
            preSignupToken: preSignupToken,
            userInformation: userInformation.toUserInformationEntityData()
        )
    }
}

struct UserInformation: Decodable {
    let email: String
    let nickname: String
    let profileImageUrl: String
    
    func toUserInformationEntityData() -> UserInformationEntityData {
        return UserInformationEntityData(
            email: email,
            nickname: nickname,
            profileImageUrl: profileImageUrl
        )
    }
}
