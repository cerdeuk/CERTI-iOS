//
//  LoginView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/4/25.
//

import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void

    var body: some View {
        VStack {
            Text("로그인 화면")
            Button("로그인 성공") {
                // 로그인 성공 시 Keychain 저장
                _ = TokenManager.shared.saveTokens(accessToken: "액세스토큰", refreshToken: "리프레시 토큰")
                onLoginSuccess()
            }
            
        }
    }
}
