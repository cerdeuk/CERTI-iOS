//
//  LicenseCardGridItemView.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct LicenseCardGridItemView: View {
    
    let model: LicenseCardModel
    let onTapFavorite: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing){
            RoundedRectangle(cornerRadius: 12)
                .fill(.clear)
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.grayscale100, lineWidth: 1)
                    )
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(model.title)
                        .applyCertiFont(.body_semibold_18)
                        .foregroundStyle(.black)
                        .padding(.trailing, 8)
                    Text(model.subtitle)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.black)
                }
                .padding(.top, 22)
                HStack(alignment: .bottom) {
                    FieldTagView(fieldTags: model.tagList, spacing: 4)
                    Spacer()
                    HStack(alignment: .center, spacing: 4) {
                        Image(.iconPaper16)
                        Text(model.type)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale500)
                    }
                    .padding(.bottom, 2)
                    .padding(.trailing, 16)
                }
                .padding(.top, 11)
                .padding(.bottom, 16)
            }
            .padding(.leading, 14)
            Button {
                onTapFavorite()
            } label: {
                Image(model.isFavorite ? .iconStar: .iconStarYellow)
            }
            .padding(.top, 12)
            .padding(.trailing, 12)
        }
        
    }
}

