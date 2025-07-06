//
//  CDTabBarView.swift
//  CERTI-iOS
//
//  Created by OneTen on 6/25/25.
//

import SwiftUI

struct CDTabBarView: View {
    @Binding var selectedTab: CDTabRoute
    
    var body: some View {
        HStack {
            ForEach(CDTabRoute.allCases, id: \.self) { tab in
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
    }
}

#Preview {
    @State var tab = CDTabRoute.home
    
    CDTabBarView(selectedTab: $tab)
}
