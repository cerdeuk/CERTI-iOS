//
//  HomeView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeCoordinator: HomeCoordinator

    let username = "김서티22"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            certiLogo
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("안녕하세요, ")
                        Text.trimmedUsername(username)
                        Text("님!")
                    }
                    .frame(height: 26)
                    .applyCertiFont(.sub_bold_20)
                    .foregroundStyle(.grayscale600)
                    .padding(.bottom, 24)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Image(.imageProfileP)
                        Text.trimmedUsername(username)

                    }
                }
            }
        }
        .padding(.horizontal, 20)

    }
}

extension HomeView {
    private var certiLogo: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.imageLogoBlack)
            Spacer()
        }
        .frame(height: 65)
        .background(.red)
    }
    
    
    
}

#Preview {
    HomeView()
        .environmentObject(HomeCoordinator())
}
