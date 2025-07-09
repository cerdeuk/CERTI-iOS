//
//  FieldTagView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct FieldTagView: View {
    
    let fieldTags: [String]
    let spacing: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: spacing) {
                ForEach(fieldTags, id: \.self) { tag in
                    tagItem(for: tag)
                }
            }
        }
    }

    private func tagItem(for text: String) -> some View {
        Text(text)
            .applyCertiFont(.caption_semibold_12)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.lightpurple)
            .foregroundColor(.mainblue)
            .clipShape(Capsule())
    }
}
