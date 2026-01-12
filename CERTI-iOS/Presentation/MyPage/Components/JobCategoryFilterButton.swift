//
//  JobCategoryFilterButton.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct JobCategoryFilterButton: View {
    let category: JobCategory
    let isSelected: Bool
    let selectedIndex: Int?
    let action: () -> Void
    
    private var isMarketing: Bool {
        return category.description == "마케팅/광고/홍보"
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .lightblue : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? .skyblue : .lightpurple, lineWidth: 1)
                    )
                    .frame(height: 42)
                
                HStack(spacing: (isMarketing && isSelected) ? 6 : 4) {
                    if let index = selectedIndex {
                        ZStack {
                            Circle()
                                .fill(.mainblue)
                                .frame(width: 15, height: 15)
                            
                            Text("\(index)")
                                .applyCertiFont(.caption_semibold_10)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // TODO: - 미니 기종만 분기처리 할 건지 논의 필요
                    
                    if isMarketing && isSelected {
                        VStack(spacing: 2) {
                            Text("마케팅/")
                                .applyCertiFont(.caption_semibold_12)
                                .foregroundStyle(.purpleblue)
                                .frame(height: 14)
                            
                            Text("광고/홍보")
                                .applyCertiFont(.caption_semibold_12)
                                .foregroundStyle(.purpleblue)
                                .frame(height: 14)
                        }
                    } else {
                        Text(category.description)
                            .applyCertiFont(.caption_semibold_12)
                            .foregroundStyle(.purpleblue)
                    }
                }
            }
        }
    }
}
