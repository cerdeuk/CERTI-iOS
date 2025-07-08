//
//  JobCategorySegmentedView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/9/25.
//

import SwiftUI

struct JobCategorySegmentedView: View {
    
    @Binding var selectedCategory: JobCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(JobCategory.allCases) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.description)
                            .applyCertiFont(.body_semibold_16)
                            .foregroundStyle(selectedCategory == category ? .grayscale500 : .grayscale400)
                    }
                }
            }
            .padding(.leading, 20)
        }
    }
}
