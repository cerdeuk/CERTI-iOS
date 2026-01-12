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
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? .lightblue : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? .skyblue : .lightpurple, lineWidth: 1)
                    )
                    .frame(height: 42)
                
                HStack(alignment: .center, spacing: 3) {
                    if let index = selectedIndex {
                        Circle()
                            .fill(.mainblue)
                            .frame(width: 15, height: 15)
                            .overlay(
                                Text("\(index)")
                                    .applyCertiFont(.caption_semibold_10)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Text(category.description)
                        .applyCertiFont(.caption_semibold_12)
                        .foregroundStyle(.purpleblue)
                    
                }
            }
        }
    }
}
