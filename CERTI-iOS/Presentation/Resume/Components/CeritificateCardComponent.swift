//
//  CeritificateCardComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/11/25.
//

import SwiftUI

import Kingfisher

struct CeritificateCardComponent: View {
    let model: CertificatedModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
                KFImage(URL(string: model.cardFrontImageUrl))
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onFailure { error in
                        print("Image Failure: \(error.localizedDescription)")
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    Text("획득 날짜: \(model.acquisitionDate)")
                        .applyCertiFont(.caption_regular_10)
                        .foregroundStyle(.white)
                        .frame(height: 15)
                        .padding(.top, 59.6)
                    
                    Spacer()
                }
                .padding(.trailing, 24)
                
                Text(model.name)
                    .foregroundStyle(.bluewhite)
                    .applyCertiFont(.caption_semibold_10)
                    .frame(height: 15)
                    .padding(.top, 139.4)
                
                TagChipMini(tags: model.tags, spacing: 6, backgroundColor: .white, textColor: .mainblue)
                    .frame(height: 19)
                    .padding(.top, 5)
            }
            .padding(.leading, 24)
        }
    }
}
