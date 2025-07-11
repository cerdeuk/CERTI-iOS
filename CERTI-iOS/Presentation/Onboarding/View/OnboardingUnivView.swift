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
            
            SearchBar(text: $searchText) {
                //
            }

            Spacer()

        }
        
    }
}

#Preview {
    OnboardingUnivView()
        .environmentObject(AppCoordinator())
}
