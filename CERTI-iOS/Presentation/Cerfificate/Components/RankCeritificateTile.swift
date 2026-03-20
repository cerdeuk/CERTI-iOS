//
//  RankCeritificateTile.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct RankCeritificateTile: View {
    let model: RankCeritificateTileModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            Text("\(model.rank)")
                .applyCertiFont(.body_bold_18)
                .foregroundStyle(.grayscale500)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 8) {
                Text(model.title)
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                
                Text(model.type)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(maxWidth: 63, alignment: .trailing)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale100, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
