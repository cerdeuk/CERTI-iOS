//
//  CeritificateCardComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

struct CeritificateCardComponent: View {
    let model: CertificatedModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("\(model.cardFrontImageUrl)")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(model.name)
                    .foregroundStyle(.grayscale600)
                    .applyCertiFont(.caption_bold_14)
                    .frame(height: 20)
                    .padding(.top, 32)
                
                Text("\(model.createdAt.toDisplayDateString()) 획득")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 18)
                    .padding(.top, 4)
                
                TagChipMini(tags: model.tags, spacing: 4)
                    .frame(height: 23)
                    .padding(.top, 8)
            }
        }
    }
}

//#Preview {
//    CeritificateCardComponent()
//}
