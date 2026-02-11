//
//  TagChipColor.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/18/25.
//

import SwiftUI

struct TagChipColor: View {
    let tags: [String]
    let fontStyle: CertiFont
    let spacing: CGFloat
    let cornerRadius: CGFloat
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
            .applyCertiFont(fontStyle)
            .frame(height: 18)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
