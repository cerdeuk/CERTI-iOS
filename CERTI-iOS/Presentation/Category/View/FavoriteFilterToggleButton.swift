//
//  FavoriteFilterToggleButton.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/9/25.
//

import SwiftUI

struct FavoriteFilterToggleButton: View {
    
    let isSelected: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    onToggle()
                } label: {
                    Text("즐겨찾기")
                        .applyCertiFont(.caption_semibold_12)
                        .frame(height: 18)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundStyle(isSelected ? .mainblue : .grayscale400)
                        .background(
                            Capsule()
                                .stroke(isSelected ? .mainblue : .grayscale100, lineWidth: 1)
                                        )
                }
            }
            .padding(.leading, 23)
            .padding(.vertical, 12)
        }
    }
}
