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
    
    enum CodingKeys: String, CodingKey {
        case needSignUp
        case preSignupToken
        case userInformation
    }
    
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
    let name: String?
    let profileImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case profileImageUrl
    }
    
    func toUserInformationEntityData() -> UserInformationEntityData {
        return UserInformationEntityData(
            email: email,
            nickname: name ?? "",
            profileImageUrl: profileImageUrl
        )
    }
}
