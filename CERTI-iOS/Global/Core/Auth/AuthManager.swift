//
//  AuthManager.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/9/26.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
        
    var temporarySignUpData: LoginResponseEntity?
    var nickname: String = ""
    var name: String = ""
    var socialType: String = ""
    var userID: Int = 0
    
    func cleanUserInfo() {
        nickname = ""
        temporarySignUpData = nil
    }
}
