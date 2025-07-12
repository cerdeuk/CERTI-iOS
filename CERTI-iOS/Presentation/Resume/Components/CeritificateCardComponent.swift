//
//  CeritificateCardComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

struct CeritificateCardComponent: View {
    var cardImage: String = "image_certification_card_small_1"
    var name: String = "GTQ 1급 (그래픽기술자격)"
    var date: String = "2025.07.05"
    var certiTag: [String] = ["태그"]
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(cardImage)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .foregroundStyle(.grayscale600)
                    .applyCertiFont(.caption_bold_14)
                    .frame(height: 20)
                    .padding(.top, 32)
                
                Text(date)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 18)
                    .padding(.top, 4)
                
                TagChip(tags: certiTag, spacing: 4)
                    .padding(.top, 8)
                    .frame(height: 23)
            }
        }
    }
}

#Preview {
    CeritificateCardComponent()
}
