//
//  TagChipMini.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/16/25.
//

import SwiftUI

struct TagChipMini: View {
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
            .applyCertiFont(.caption_regular_10)
            .frame(height: 15)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
