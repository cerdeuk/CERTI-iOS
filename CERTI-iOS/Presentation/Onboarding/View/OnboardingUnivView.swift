//
//  OnboardingUnivView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct OnboardingUnivView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator

    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                appCoordinator.cancelOnboarding()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar1)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
            Text("대학교 이름을 입력해주세요")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .padding(.leading, 20)
                .padding(.bottom, 38)
            
            SearchBar(text: $searchText) {
                //
            }
            .padding(.horizontal, 20)

            Spacer()

            Button {
                // 다음 뷰 전환
            } label: {
                Text("다음")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale400)
                    .frame(maxWidth: .infinity, minHeight: 56)
            }
            .background(.grayscale100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 20)
            .padding(.bottom, 22)

            
        }
    }
}

#Preview {
    OnboardingUnivView()
        .environmentObject(AppCoordinator())
}
