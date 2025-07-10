//
//  FavoriteLicenseCard.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/10/25.
//

import SwiftUI

struct FavoriteLicenseCard: View {
    let licenseCard: FavoriteLicenseCardModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(licenseCard.certificationType)
                    .applyCertiFont(.caption_regular_14)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 20)
                    .padding(.bottom, 8)
                
                Text(licenseCard.certificationName)
                    .applyCertiFont(.body_bold_18)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 25)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconPaper16)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 4)
                    
                    Text(licenseCard.testType)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale500)
                    
                    Spacer()
                }
                .frame(height: 18)
                .padding(.bottom, 8)
                
                HStack(alignment: .center, spacing: 0) {
                    Image(.iconCertification16)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 4)
                    
                    Text(licenseCard.agencyName)
                        .applyCertiFont(.caption_regular_12)
                        .foregroundStyle(.grayscale500)
                    
                    Spacer()
                }
                .frame(height: 18)
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 14)
            .frame(width: 160, height: 160)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    Button {
                        // 즐겨찾기
                    } label: {
                        Image(.iconStarYellow)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.top, 16)
                    .padding(.trailing, 14)
                    
                }
                Spacer()
            }
            
        }
        .frame(width: 160, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.grayscale100, lineWidth: 1)
        }
    }
}

#Preview {
    FavoriteLicenseCard(licenseCard: FavoriteLicenseCardModel.dummy().first!)
}
