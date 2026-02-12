//
//  NotificationSettingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/1/25.
//

import SwiftUI

struct NotificationSettingView: View {
    @Environment(\.openURL) var openURL
    
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var showConfirmationAlert = false
    @State private var showToastMessage = false
    @State private var showHelpPopup = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                MyPageHeader(style: .normal, title: "알림 설정") {
                    nil
                } backButtonAction: {
                    viewModel.myPageViewRoutePop()
                }
                
                agreeToggleButton
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                
                Text("마케팅을 위한 이벤트, 공지사항 등의 소식 알림 받기")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale400)
                    .frame(height: 20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                
                checkBoxSection
                
                Spacer()
            }
            .overlay(alignment: .top) {
                if showHelpPopup {
                    helpPopup
                }
            }
            .zIndex(1)
            
            if showConfirmationAlert {
                CertiAlertView(
                    style: .onlyTitle,
                    onConfirm: {
                        Task {
                            await viewModel.toggleMarketingSetting()
                            await viewModel.togglePrivacySetting()
                            withAnimation {
                                showConfirmationAlert = false
                            }
                            showToastMessage = true
                            try await Task.sleep(for: .seconds(2))
                            showToastMessage = false
                        }
                    },
                    onCancel: {
                        withAnimation {
                            showConfirmationAlert = false
                        }
                    },
                    titleMessage: "개인정보 수집 이용에 동의해야 이벤트 및 혜택 안내를 받을 수 있습니다. \n동의하시겠습니까?",
                    confirmText: "확인",
                    cancelText: "취소"
                )
                .transition(.opacity)
                .zIndex(2)
            }
            
            
            if showToastMessage {
                ToastMessageView(
                    message: "광고성 정보를 받는 것에 동의했어요. \(dateFormatter.string(from: Date()))",
                    style: .agreeMarketing
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(3)
                .padding(.bottom, 36)
            }
        }
        .task {
            await viewModel.getNotificationSetting()
        }
        .animation(.spring, value: showToastMessage)
        
    }
}

extension NotificationSettingView {
    @ViewBuilder
    private var agreeToggleButton: some View {
        let toggleBinding = Binding<Bool>(
            get: {
                viewModel.marketingAgreeState
            },
            set: { newValue in
                if newValue == true {
                    withAnimation {
                        showConfirmationAlert = true
                    }
                } else {
                    Task {
                        await viewModel.toggleMarketingSetting()
                        await viewModel.togglePrivacySetting()
                    }
                    showToastMessage = false
                }
            }
        )
        
        Toggle(isOn: toggleBinding) {
            HStack(alignment: .center, spacing: 0) {
                Text("광고성 정보 수신 동의")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                    .padding(.trailing, 4)
                
                Button {
                    showHelpPopup.toggle()
                } label: {
                    Image(.iconQuestion24)
                }
            }
        }
        .tint(.purpleblue)
        .frame(height: 24)
    }
    
    @ViewBuilder
    private var checkBoxSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: viewModel.marketingAgreeState ? "checkmark.square.fill" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(viewModel.marketingAgreeState ? .grayscale500 : .grayscale400)
                    .padding(.trailing, 12)
                
                Text("(선택)")
                    .applyCertiFont(.body_regular_16)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 4)
                
                Text("따요 개인정보 수집 및 이용 동의")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    openURL(URL(string: "https://tremendous-baryonyx-347.notion.site/3015e9d69a2680a98ce4e96faf2ce06d?pvs=73")!)
                } label: {
                    Image(.iconArrowright24)
                }
                
            }
            .frame(height: 24)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            .padding(.top, 16)
            
            Text("이벤트 소식 알림을 받으려면 먼저 개인정보 수집 및 이용에 동의해주세요.")
                .applyCertiFont(.caption_regular_14)
                .foregroundStyle(.grayscale400)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            
        }
        .background(.grayscale0)
    }
    
    @ViewBuilder
    private var helpPopup: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 0) {
                Text("광고성 정보 수신 동의")
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.grayscale500)
                
                Spacer()
                
                Button {
                    showHelpPopup = false
                } label: {
                    Image(.iconClose20)
                }
            }
            
            Text("회원이 수집 및 이용에 동의한 개인정보를 서티에서 활용하는 것에 동의하며,해당 개인정보를 활용하여 이메일/SMS를 통해 서비스에 대한 개인 맞춤형 광고 정보(혜택·소식 메일,광고메일,문자알림)를 전송할 수 있어요.")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale400)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(.white)
        .frame(width: 216)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.grayscale400, lineWidth: 1)
        }
        .padding(.top, 120)
        .padding(.leading, 40)
    }
}
