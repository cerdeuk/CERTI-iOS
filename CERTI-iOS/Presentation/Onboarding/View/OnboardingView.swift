//
//  OnboardingView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void

    var body: some View {
        VStack {
            Text("온보딩 화면")
            Button("온보딩 완료") {
                onComplete()
            }
        }
    }
}
