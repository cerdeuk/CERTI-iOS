//
//  TrackCategorySegmentedControl.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

enum TrackList: String, CaseIterable, Identifiable {
    case management = "인문계열"
    case health = "사회계열"
    case it = "교육계열"
    case safety = "자연계열"
    case safety1 = "공학계열"
    case safety2 = "의약계열"
    case safety3 = "예체능계열"
    
    var id: String { self.rawValue }
    var description: String { self.rawValue }
}

struct TrackCategorySegmentedControl: View {
    
    @Binding var selectedCategory: TrackList
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 24) {
                ForEach(TrackList.allCases) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.description)
                            .applyCertiFont(.body_semibold_16)
                            .frame(height: 22)
                            .foregroundStyle(selectedCategory == category ? .grayscale500 : .grayscale400)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
    }
}
