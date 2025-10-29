//
//  SettingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/30/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            notificationSetting
                .padding(.bottom, 36)
                .padding(.top, 20)
            
            privacyPolicy
                .padding(.bottom, 36)
            
            withDraw
                .padding(.bottom, 36)

            appVersion
                .padding(.bottom, 36)
            
            logout
            
            Spacer()
        }
    }
}

extension SettingView {
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                viewModel.myPageViewRoutePop()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            Text("설정")
                .applyCertiFont(.sub_semibold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 25)
            
            Spacer()
            
            Rectangle()
                .foregroundStyle(.clear)
                .frame(width: 36)
        }
        .padding(.horizontal, 20)
        .frame(height: 68)
    }
    
    @ViewBuilder
    private var notificationSetting: some View {
        Button {
            // TODO: - 알림설정 이동
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("알림 설정")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                    .frame(height: 22)
                
                Spacer()
                
                Image(.iconArrowright24)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 24)
    }
    
    @ViewBuilder
    private var privacyPolicy: some View {
        Button {
            // TODO: - 개인정보처리방침 이동
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("개인정보 처리방침")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                    .frame(height: 22)
                
                Spacer()
                
                Image(.iconArrowright24)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 24)
    }
    
    @ViewBuilder
    private var withDraw: some View {
        Button {
            // TODO: - 탈퇴하기
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("회원 탈퇴")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                    .frame(height: 22)
                
                Spacer()
                
                Image(.iconArrowright24)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 24)
    }
    
    @ViewBuilder
    private var appVersion: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("앱버전")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.black)
                .frame(height: 22)
            
            Spacer()
            
            Text("v \(version)")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale500)
                .frame(height: 22)
        }
        .frame(height: 24)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var logout: some View {
        Button {
            //TODO: - 로그아웃
        } label: {
            Text("로그아웃")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, minHeight: 48)
        }
        .overlay(content: {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale300, lineWidth: 1)
        })
        .padding(.horizontal, 20)
    }
}
