//
//  OnboardingInfoView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingInfoView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    @State private var username = AuthManager.shared.nickname
    @State private var isShowLoadingView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(.imageOnboardingFirework)
                .padding(.bottom, 60)
            
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    viewModel.onboardingViewRoutePop()
                }
                .padding(.bottom, 35)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text(username.trimmedUsername())
                        .foregroundStyle(.mainblue)
                    
                    Text("님,")
                        .foregroundStyle(.black)
                        .padding(.trailing, 8)
                    
                    Image(.imageOnboardingImageSmall)
                }
                .applyCertiFont(.sub_bold_20)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
                
                Text("이제 서티와 함께 해요!")
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.black)
                    .padding(.bottom, 46)
                    .padding(.horizontal, 20)
                
                Text("최종학력")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                    .frame(height: 25)
                    .padding(.bottom, 14)
                    .padding(.horizontal, 20)
                
                Text(viewModel.userUniversity)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.mainblue)
                    .frame(height: 22)
                    .padding(.bottom, 36)
                    .padding(.horizontal, 20)
                
                Text("학과")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                    .frame(height: 25)
                    .padding(.bottom, 14)
                    .padding(.horizontal, 20)
                
                Text(viewModel.userMajor)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.mainblue)
                    .frame(height: 22)
                    .padding(.bottom, 36)
                    .padding(.horizontal, 20)
                
                Text("희망직무")
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                    .frame(height: 25)
                    .padding(.bottom, 14)
                    .padding(.horizontal, 20)
                
                jobCategoryList
                    .padding(.bottom, 36)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    isShowLoadingView = true
                    Task {
                        let success = await viewModel.signUp()
                        
                        if success {
                            try await Task.sleep(for: .seconds(2))
                            viewModel.onboardingViewRouteReset()
                            viewModel.completeOnboarding()
                            isShowLoadingView = false
                        } else {
                            print("회원가입 실패")
                        }
                    }
                } label: {
                    Text("시작하기")
                        .applyCertiFont(.body_semibold_16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(.purpleblue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom, 22)
                .padding(.horizontal, 20)
                
            }
            
        }
        .overlay {
            if isShowLoadingView {
                CertiLoadingView(name: username.trimmedUsername())
            }
        }
    }
}

extension OnboardingInfoView {
    @ViewBuilder
    private var jobCategoryList: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center, spacing: 0) {
                Text("1순위")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 10)
                
                if viewModel.selectedJobCategory.count > 0 {
                    Text(viewModel.selectedJobCategory[0])
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.mainblue)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.purplewhite)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("-")
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.grayscale400)
                }
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text("2순위")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 10)
                
                if viewModel.selectedJobCategory.count > 1 {
                    Text(viewModel.selectedJobCategory[1])
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.mainblue)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.purplewhite)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("-")
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.grayscale400)
                }
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text("3순위")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale400)
                    .padding(.trailing, 10)
                
                if viewModel.selectedJobCategory.count > 2 {
                    Text(viewModel.selectedJobCategory[2])
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.mainblue)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.purplewhite)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("-")
                        .applyCertiFont(.caption_semibold_14)
                        .foregroundStyle(.grayscale400)
                }
            }
        }
    }
}
