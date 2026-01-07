//
//  CertificateDetailTab.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/7/26.
//

import SwiftUI

enum DetailTab: CaseIterable {
    case detailInformation
    case comment
    
    var title: String {
        switch self {
        case .detailInformation: return "상세정보"
        case .comment : return "댓글"
        }
    }
}

struct CertificateDetailTab: View {
    @Namespace private var animation
    @Binding var selectedTab: DetailTab
    
    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            ForEach(DetailTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(alignment: .center, spacing: 10) {
                        Text(tab.title)
                            .applyCertiFont(.body_bold_16)
                            .foregroundColor(selectedTab == tab ? .grayscale600 : .grayscale300)
                        
                        ZStack {
                            if selectedTab == tab {
                                Rectangle()
                                    .frame(width: selectedTab ==  .detailInformation ? 76 : 48, height: 2)
                                    .foregroundColor(.grayscale600)
                                    .matchedGeometryEffect(id: "underline", in: animation)
                            } else {
                                Rectangle()
                                    .frame(width: selectedTab ==  .comment ? 76 : 48, height: 2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab: DetailTab = .comment
        
        var body: some View {
            CertificateDetailTab(selectedTab: $selectedTab)
        }
    }
    return PreviewWrapper()
}
