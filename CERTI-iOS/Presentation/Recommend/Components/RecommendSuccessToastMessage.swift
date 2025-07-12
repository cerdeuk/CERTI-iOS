//
//  RecommendSuccessToastMessage.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/12/25.
//

import SwiftUI

struct RecommendSuccessToastMessage: View {
        let title: String
        let subtitle: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.iconProgresscheck)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundColor(.grayscale0)
                    .frame(height: 20)
                
                Text(subtitle)
                    .applyCertiFont(.caption_regular_14)
                    .foregroundColor(.grayscale400)
                    .padding(.top, 8)
            }
            .padding(.leading, 16)
        }
        .padding(.vertical, 22)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.blackOpacity85)
        )
    }
}
