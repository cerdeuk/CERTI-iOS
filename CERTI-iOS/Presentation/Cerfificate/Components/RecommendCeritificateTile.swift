//
//  RecommendCeritificateTile.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct RecommendCeritificateTile: View {
    let id: Int
    let title: String
    let score: Int
    let description: String
    let tags: [String]
    
    let gradientColor: LinearGradient = LinearGradient(
        colors: [.purpleblue, .bluepurpleGradient],
        startPoint: .leading,
        endPoint: .trailing
    )
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 8) {
                Text(title)
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.black)
                
                Divider()
                    .frame(width: 1, height: 5)
                
                Text("추천점수 \(score)점")
                    .applyCertiFont(.caption_bold_14)
                    .foregroundStyle(gradientColor)
            }
            .padding(.bottom, 8)
            
            Text(description)
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale600)
                .lineLimit(1)
                .padding(.bottom, 10)
            
            HStack(spacing: 6) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .applyCertiFont(.caption_semibold_12)
                        .foregroundStyle(.mainblue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white)
                        .clipShape(.capsule)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.purplewhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
