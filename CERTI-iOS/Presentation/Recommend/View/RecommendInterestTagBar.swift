//
//  RecommendInterestTagBar.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

struct RecommendInterestTagBar: View {
    
    @Binding var isModalPresented: Bool
    let interestTags: [String] = [JobCategory.marketing.description, JobCategory.sales.description,
                                  JobCategory.rnd.description]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                Button {
                    isModalPresented = true
                } label: {
                    Text("희망분야 재설정하기")
                        .applyCertiFont(.caption_semibold_12)
                        .frame(height: 18)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(.mainblue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.mainblue, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
                ForEach(interestTags, id: \.self) { tag in
                    Text(tag)
                        .applyCertiFont(.caption_regular_12)
                        .frame(height: 18)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(.grayscale600)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundStyle(.grayscale0)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .padding(.leading, 20)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
    }
}
