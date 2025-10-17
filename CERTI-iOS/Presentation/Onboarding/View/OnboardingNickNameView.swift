//
//  OnboardingNickNameView.swift
//  CERTI-iOS
//
//  Created by OneTen on 10/17/25.
//

import SwiftUI

struct OnboardingNickNameView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BackButton {
                viewModel.onboardingViewRoutePop()
            }
            .padding(.bottom, 13)
            
            Image(.onboardingProgressbar5)
                .padding(.leading, 20)
                .padding(.bottom, 40)
            
        }
    }
}

#Preview {
    let onboardingFactory: OnboardingFactory = AppDIContainer.shared.makeOnboardingFactory()
    @StateObject var onBoardingViewModel = onboardingFactory.makeOnboardingViewModel()
   
    OnboardingNickNameView(viewModel: onBoardingViewModel)
}
