//
//  LicenseCardItem.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/8/25.
//

import SwiftUI

struct LicenseCardItem: View {
    
    let model: LicenseCardModel
    let onTapFavorite: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing){
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale100, lineWidth: 1)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text(model.certificationName)
                        .applyCertiFont(.body_semibold_18)
                        .foregroundStyle(.black)
                        .frame(height: 25)
                        .padding(.trailing, 8)
                    
                    Text(model.certificationType)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.black)
                        .frame(height: 18)
                }
                .padding(.top, 22)
                
                HStack(alignment: .bottom, spacing: 0) {
                    TagChip(tags: model.tags, spacing: 4)
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 4) {
                        Image(.iconPaper16)
                        Text(model.testType)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale500)
                            .frame(height: 18)
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
                Image(model.isFavorite ? .iconStarYellow : .iconStar)
            }
            .padding(.top, 12)
            .padding(.trailing, 12)
        }
    }
}

