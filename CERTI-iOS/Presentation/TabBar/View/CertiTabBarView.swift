//
//  CertiTabBarView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CertiTabBarView: View {
    @Binding var selectedTab: CertiTabRoute
    
    var body: some View {
        HStack {
            ForEach(CertiTabRoute.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(alignment: .center, spacing: 2) {
                        Image(uiImage: tab.icon)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)

                        Text(tab.title)
                            .applyCertiFont(.caption_semibold_10)
                    }
                    .foregroundStyle(selectedTab == tab ? .mainblue : .grayscale600)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(height: 49)
        .background(.white)
    }
}
