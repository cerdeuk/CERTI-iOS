//
//  SplashView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Image(.imageSplashLogo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 265, height: 87)
                    .padding(.bottom, 116)
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(.mainblue)
    }
    
}

#Preview {
    SplashView()
}
