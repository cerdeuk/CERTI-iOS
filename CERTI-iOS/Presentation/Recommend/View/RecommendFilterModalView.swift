//
//  RecommendFilterModalView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/11/25.
//

import SwiftUI

struct RecommendFilterModalView: View {
    @State private var selectedCategories: [JobCategory] = []
    
    var body: some View {
        
        header
        
        RecoommendFilterButtonList
        
        ApplyButton
        
        Spacer()
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing:0) {
            Text("필터")
                .applyCertiFont(.sub_bold_20)
                .foregroundStyle(.grayscale600)
                .frame(height: 24)
                .padding(.leading, 20)
                .padding(.top, 73)
            
            Text("희망직무/분야 재설정하기")
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.mainblue)
                .frame(height: 20)
                .padding(.leading, 20)
                .padding(.top, 12)
            
            Text("복수 선택이 가능합니다 (최대 3개)")
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale500)
                .frame(height: 18)
                .padding(.leading, 20)
                .padding(.top, 3)
            
            Rectangle()
                .fill(Color.grayscale200)
                .frame(height: 1)
                .padding(.top, 10)
                .padding(.horizontal, 20)
        }
    }
    
    private var RecoommendFilterButtonList: some View {
        LazyVGrid(columns: Array(repeating: .init(spacing: 16), count: 3), spacing: 13) {
            ForEach(JobCategory.allCases) {category in
                RecommendFilterButton(category: category, isSelected: selectedCategories.contains(category)) {
                    if selectedCategories.contains(category) {
                        selectedCategories.removeAll { $0 == category }
                    } else if selectedCategories.count < 3 {
                        selectedCategories.append(category)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 36)
    }
    
    private var ApplyButton: some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.purpleblue)
                    .frame(height: 56)
                
                Text("적용하기")
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.white)
                    .frame(height: 22)
            }
            .padding(.horizontal, 20)
            .padding(.top, 53)
        }
        
    }
}
