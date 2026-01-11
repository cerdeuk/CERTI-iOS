//
//  FavoriteCertificationItem.swift
//  CERTI-iOS
//
//  Created by OneTen on 1/12/26.
//

import SwiftUI

struct FavoriteCertificationItem: View {
    let title: String
    let category: String
    let testType: String
    let organization: String
    @State var isFavorite: Bool = true

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 8) {
                    Text(title)
                        .applyCertiFont(.sub_semibold_20)
                        .foregroundStyle(.black)
                    
                    Text(category)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.black)
                }
                
                HStack(alignment: .center, spacing: 8) {
                    HStack(alignment: .center, spacing: 4) {
                        Image(.iconPaper16)
                        
                        Text(testType)
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.black)
                    }
                    
                    HStack(alignment: .center, spacing: 4) {
                        Image(.iconCertification16)

                        Text(organization)
                            .applyCertiFont(.caption_regular_14)
                            .foregroundStyle(.black)
                    }
                }
            }
            
            Spacer()
            
            Button {
                // TODO: 즐겨찾기 해제 로직 연결
                isFavorite.toggle()
            } label: {
                Image(isFavorite ? .iconStarYellow : .iconStar)
            }
        }
        .padding(20)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale100, lineWidth: 1)
        }
    }
}
