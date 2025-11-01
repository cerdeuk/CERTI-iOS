//
//  NotificationSettingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/1/25.
//

import SwiftUI

struct NotificationSettingView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    // TODO: - Userdefault로 관리해야 하나? 아니면 앱 내부 설정을 불러올 수 있는 기능이 있나? 좀 찾아보기
    @State private var agreeState: Bool = false
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
                headerView
                
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
                            agreeState = true
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
        .animation(.spring, value: showToastMessage)
        
    }
}

extension NotificationSettingView {
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                viewModel.myPageViewRoutePop()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()
            
            Text("알림 설정")
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
    private var agreeToggleButton: some View {
        let toggleBinding = Binding<Bool>(
            get: {
                agreeState
            },
            set: { newValue in
                if newValue == true {
                    withAnimation {
                        showConfirmationAlert = true
                    }
                } else {
                    agreeState = false
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
                Image(systemName: agreeState ? "checkmark.square.fill" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(agreeState ? .grayscale500 : .grayscale400)
                    .padding(.trailing, 12)
                
                Text("(선택)")
                    .applyCertiFont(.body_regular_16)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 4)
                
                Text("서티 개인정보 수집 및 이용 동의")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    // 노션이동
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
