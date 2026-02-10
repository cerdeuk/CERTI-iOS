//
//  CertificateListTile.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/28/26.
//

import SwiftUI

struct CertificateListTile: View {

    let title: String
    let type: String
    let description: String
    let tags: [String]
    let testType: String
    
    @State var isFavorite: Bool
    var onToggleFavorite: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 8) {
                Text(title)
                    .applyCertiFont(.body_semibold_18)
                    .foregroundStyle(.black)
                
                Text(type)
                    .applyCertiFont(.caption_semibold_12)
                    .foregroundStyle(.purpleblue)
                
                Spacer()
                
                Button {
                    isFavorite.toggle()
                    onToggleFavorite?()
                } label: {
                    Image(isFavorite ? .iconStarYellow : .iconStar)
                }
            }
            .padding(.vertical, 12)
            
            Text(description)
                .applyCertiFont(.caption_regular_12)
                .foregroundStyle(.grayscale500)
                .lineLimit(2)
                .padding(.bottom, 12)
            
            HStack(alignment: .center, spacing: 0) {
                HStack(spacing: 4) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .applyCertiFont(.caption_semibold_12)
                            .foregroundStyle(.mainblue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.lightpurple)
                            .clipShape(.capsule)
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconPaper16)
                    
                    Text(testType)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale500)
                }
            }
            .padding(.trailing, 3)
            .padding(.bottom, 16)
            
        }
        .padding(.horizontal, 22)
        .background(.white)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
}
