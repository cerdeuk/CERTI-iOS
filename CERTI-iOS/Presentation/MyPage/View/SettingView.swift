//
//  SettingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/30/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var showLogoutAlert = false
    @State private var showWithDrawAlert = false
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                MyPageHeader(style: .normal, title: "설정") {
                    nil
                } backButtonAction: {
                    viewModel.myPageViewRoutePop()
                }
                
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
            .zIndex(1)
            
            if showLogoutAlert {
                CertiAlertView(
                    style: .plain,
                    onConfirm: {
                        Task {
                            //TODO: - 로그아웃 로직
                            
                            withAnimation {
                                showLogoutAlert = false
                            }
                        }
                    },
                    onCancel: {
                        withAnimation {
                            showLogoutAlert = false
                        }
                    },
                    titleMessage: "로그아웃하시겠습니까?",
                    subTitleMessage: "로그아웃 시 재로그인이 필요합니다.",
                    confirmText: "확인",
                    cancelText: "취소"
                )
                .transition(.opacity)
                .zIndex(2)
            }
            
            if showWithDrawAlert {
                CertiAlertView(
                    style: .withdraw,
                    onConfirm: {
                        Task {
                            await viewModel.withDraw()
                            viewModel.withDrawNavigate()
                            
                            withAnimation {
                                showWithDrawAlert = false
                            }
                        }
                    },
                    onCancel: {
                        withAnimation {
                            showWithDrawAlert = false
                        }
                    },
                    titleMessage: "회원 탈퇴를 진행하시겠습니까?",
                    subTitleMessage: "탈퇴 시 모든 개인 정보와 자격증, 학습 데이터, 저장된 이력서 정보가 영구적으로 삭제되며 이후 복구가 불가능합니다.",
                    confirmText: "탈퇴",
                    cancelText: "취소"
                )
                .transition(.opacity)
                .zIndex(2)
            }
            
            
        }
    }
}

extension SettingView {
    @ViewBuilder
    private var notificationSetting: some View {
        Button {
            viewModel.navigateToNotificationSettings()
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
            withAnimation {
                showWithDrawAlert = true
            }
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
            withAnimation {
                showLogoutAlert = true
            }
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
