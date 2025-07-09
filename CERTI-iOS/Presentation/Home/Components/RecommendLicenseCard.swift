//
//  RecommendLicenseCard.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/9/25.
//

import SwiftUI

struct RecommendLicenseCard: View {
    let licenseCard: RecommendLicenseCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                Text(licenseCard.licenseName)
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                
                VStack{}
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .background(.grayscale200)
                    .padding(.vertical, 5)
                
                Text("추천점수 \(licenseCard.recommendScore)점")
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale500)
                
                Spacer()
            }
            .frame(height: 25)
            .padding(.top, 9)
            
            TagChip(tags: licenseCard.tagChip, spacing: 6)
            
        }
        .padding(.leading, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.purplewhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
