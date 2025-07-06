//
//  LoginView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/4/25.
//

import SwiftUI

struct LoginView: View {
    //    let onLoginSuccess: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(.imageLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 44)
                .padding(.bottom, 20)
                .padding(.top, 137)
            
            Text ("나만의 자격증 취득 올인원 서비스")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .padding(.bottom, 27)
            
            Image(.imageLogin)
                .resizable()
                .scaledToFit()
                .frame(width: 255, height: 298)
                .padding(.bottom, 72)
            
            Button {
                // 카카오 로그인
            } label: {
                Image(.imageSocialLoginKakao)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 335, height: 56)
            }
            .padding(.bottom, 12)
            
            Button {
                // 애플 로그인
            } label: {
                Image(.imageSocialLoginApple)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 335, height: 56)
            }

        }
        .ignoresSafeArea()
        .background(.white)
    }
}

#Preview {
    LoginView()
}
