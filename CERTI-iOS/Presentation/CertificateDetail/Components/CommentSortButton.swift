//
//  CommentSortButton.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 1/8/26.
//

import SwiftUI

struct CommentSortButton: View {
    let isSelectedPopularity: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Button {
                    onToggle()
                } label: {
                    Text("인기순")
                        .applyCertiFont(.caption_semibold_12)
                        .padding(.horizontal, 17)
                        .padding(.vertical, 6)
                        .frame(width:66, height: 30)
                        .foregroundStyle(isSelectedPopularity ? .mainblue : .grayscale400)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(isSelectedPopularity ? .mainblue : .grayscale100, lineWidth: 1)
                        )
                }
                
                Button {
                    onToggle()
                } label: {
                    Text("최신순")
                        .applyCertiFont(.caption_semibold_12)
                        .padding(.horizontal, 17)
                        .padding(.vertical, 6)
                        .frame(width:66, height: 30)
                        .foregroundStyle(isSelectedPopularity ? .grayscale400 : .mainblue)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(isSelectedPopularity ? .grayscale100 : .mainblue, lineWidth: 1)
                        )
                }
            }
            .padding(.leading, 20)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isSelected = true
        
        var body: some View {
            CommentSortButton(
                isSelectedPopularity: isSelected,
                onToggle: {
                    isSelected.toggle()
                }
            )
        }
    }
    
    return PreviewWrapper()
}
