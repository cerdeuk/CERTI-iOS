//
//  TagChipColor.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/18/25.
//

import SwiftUI

struct TagChipColor: View {
    let tags: [String]
    let spacing: CGFloat
    let backgroundColor: Color 
    let textColor: Color

    var body: some View {
        LazyHStack(spacing: spacing) {
            ForEach(tags, id: \.self) { tag in
                tagItem(for: tag)
            }
        }
    }

    private func tagItem(for text: String) -> some View {
        Text(text)
            .applyCertiFont(.caption_semibold_12)
            .frame(height: 18)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
