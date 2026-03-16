//
//  JobCategorySegmentedControl.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/9/25.
//

import SwiftUI

struct JobCategorySegmentedControl: View {
    
    @Binding var selectedCategory: JobCategory
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 24) {
                ForEach(JobCategory.allCases) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.description)
                            .applyCertiFont(selectedCategory == category ? .body_bold_16 : .body_semibold_16)
                            .frame(height: 22)
                            .foregroundStyle(selectedCategory == category ? .grayscale500 : .grayscale300)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
    }
}
