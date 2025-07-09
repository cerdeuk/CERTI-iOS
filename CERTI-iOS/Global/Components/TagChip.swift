//
//  TagChip.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct TagChip: View {
    
    let tags: [String]
    let spacing: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: spacing) {
                ForEach(tags, id: \.self) { tag in
                    tagItem(for: tag)
                }
            }
        }
    }

    private func tagItem(for text: String) -> some View {
        Text(text)
            .applyCertiFont(.caption_semibold_12)
            .frame(height: 18)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.lightpurple)
            .foregroundColor(.mainblue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
