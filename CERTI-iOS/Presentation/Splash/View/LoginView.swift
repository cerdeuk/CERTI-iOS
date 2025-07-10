//
//  LoginView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/4/25.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - Property Wrappers
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @StateObject private var viewModel = LoginViewModel()

    //MARK: - Properties

    @State var isAnimating: Bool = false

    //MARK: - Main Body
    
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
                .frame(width: 255, height: 243)
                .padding(.bottom, 28)
                .offset(y: isAnimating ? 0 : 10)
                .animation(.easeInOut.repeatForever().speed(0.3), value: isAnimating)
            
            Image(.imageLoginShadow)
                .resizable()
                .scaledToFit()
                .frame(width: 172, height: 19)
                .padding(.bottom, 84)
            
            Button {
                // 카카오 로그인
                viewModel.kakaoLogin()
//                appCoordinator.completeLogin()
            } label: {
                Image(.imageSocialLoginKakao)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 335, height: 56)
            }
            .padding(.bottom, 12)
            
            Button {
                // 애플 로그인
                appCoordinator.completeLogin()
            } label: {
                Image(.imageSocialLoginApple)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 335, height: 56)
            }
            
        }
        .ignoresSafeArea()
        .background(.white)
        .onAppear {
            isAnimating = true
        }
    }
}
