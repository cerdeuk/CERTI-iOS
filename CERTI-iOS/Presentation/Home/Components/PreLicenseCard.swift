//
//  PreLicenseCard.swift
//  CERTI-iOS
//
//  Created by OneTen on 7/9/25.
//

import SwiftUI

struct PreLicenseCard: View {
    let licenseCard: PreLicenseCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(licenseCard.certificationName)
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(.grayscale600)
                .frame(height: 22)
                .padding(.bottom, 8)
                .padding(.horizontal, 12)

            Text("평균 취득 기간 약 \(licenseCard.averagePeriod)")
                .applyCertiFont(.caption_semibold_12)
                .foregroundStyle(.grayscale600)
                .frame(height: 18)
                .padding(.bottom, 8)
                .padding(.horizontal, 12)

            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Image(.iconDate16)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 4)
                        
                        Text(licenseCard.testDate)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale500)
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        Image(.iconCertification16)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 4)
                        
                        Text(licenseCard.agencyName)
                            .applyCertiFont(.caption_regular_12)
                            .foregroundStyle(.grayscale500)
                    }
                }
                
                Spacer()
                
                Image("serti_emoji\(licenseCard.imageIndex+1)")
            }
            .padding(.horizontal, 12)
        }
        .frame(width: 200, height: 132)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

#Preview {
    PreLicenseCard(licenseCard: PreLicenseCardModel.dummy().first!)
}
