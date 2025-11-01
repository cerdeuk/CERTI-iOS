//
//  NotificationSettingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/1/25.
//

import SwiftUI

struct NotificationSettingView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    @State private var agreeState: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            agreeToggleButton
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            
            
            Spacer()
        }
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
        Toggle(isOn: $agreeState) {
            HStack(alignment: .center, spacing: 0) {
                Text("광고성 정보 수신 동의")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.black)
                    .padding(.trailing, 4)
                
                Button {
                    // 도움말 팝업
                } label: {
                    Image(.iconQuestion24)
                }
            }
        }
        .tint(.purpleblue)
        .frame(height: 24)
    }
    
    
}
