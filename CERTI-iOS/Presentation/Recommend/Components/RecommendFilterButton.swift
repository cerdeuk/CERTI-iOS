//
//  RecommendFilterButton.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/11/25.
//

import SwiftUI

struct RecommendFilterButton: View {
    let category: JobCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .lightblue : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.skyblue : Color.lightpurple, lineWidth: 1)
                    )
                .frame(width: 101, height: 42)
            
            Text(category.description)
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.purpleblue)
                .frame(height: 18)
        }
        .onTapGesture {
            action()
        }
    }
}
