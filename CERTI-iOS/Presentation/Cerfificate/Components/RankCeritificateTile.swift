//
//  RankCeritificateTile.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct RankCeritificateTile: View {

    let rank: Int
    let title: String
    let type: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            Text("\(rank)")
                .applyCertiFont(.body_bold_18)
                .foregroundStyle(.grayscale500)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 8) {
                Text(title)
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                
                Text(type)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
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
