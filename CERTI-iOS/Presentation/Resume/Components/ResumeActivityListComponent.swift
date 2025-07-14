//
//  ResumeActivityListComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeActivityListComponent: View {
    let model: ResumeModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(model.startAt) ~ \(model.endAt)")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(height: 18)
                
                Text.trimmedResumeInfo(model.place, 10)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(height: 18)
                    .padding(.top, 12)
            }
            .frame(height: 48)

            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text.trimmedResumeInfo(model.name, 9)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(height: 22)
                
                Text.trimmedResumeInfo(model.discription, 15)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .lineLimit(1)
                    .frame(height: 18)
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    ResumeActivityListComponent(model: ResumeModel.myCareerDummy().first!)
}
