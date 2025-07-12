//
//  OnboardingInfoView.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/12/25.
//

import SwiftUI

struct OnboardingInfoView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var onboardingCoordinator: OnboardingCoordinator
    @ObservedObject var viewModel: OnboardingViewModel

    @State private var username = "김서티22"
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(.imageOnboardingFirework)
                .padding(.bottom, 60)
            
            VStack(alignment: .leading, spacing: 0) {
                BackButton {
                    onboardingCoordinator.pop()
                }
                .padding(.bottom, 35)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text.trimmedUsername(username)
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

                VStack(alignment: .leading, spacing: 13) {
                    ForEach(viewModel.selectedJobCategory, id: \.self) { job in
                        Text(job)
                            .applyCertiFont(.caption_semibold_14)
                            .foregroundStyle(.mainblue)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.purplewhite)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.bottom, 36)
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    appCoordinator.completeOnboarding()
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
    }
}
