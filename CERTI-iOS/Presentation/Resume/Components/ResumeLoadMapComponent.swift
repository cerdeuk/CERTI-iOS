//
//  ResumeMyCareerItem.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeLoadMapComponent: View {
    let model: ResumeModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(.resumeList)
                .frame(width: 24, height: 24)
                .offset(x:0, y: 0)
                .padding(.trailing, 24)
            
            VStack(spacing: 0) {
                Text("\(model.startAt) ~ \(model.endAt)")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(width: 104, height: 18)
                
                Text(model.place)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(width: 105, height: 18)
                    .padding(.top, 12)
            }
            .frame(width: 104, height: 48)

            Spacer()
            
            VStack(spacing: 0) {
                Text(model.name)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(width: 137, height: 22)
                
                Text(model.discription)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .lineLimit(1)
                    .frame(width: 138, height: 18)
                    .padding(.top, 10)
            }
            .frame(width: 137, height: 50)
        }
        .frame(height: 74)
    }
}

#Preview {
    ResumeLoadMapComponent(model: ResumeModel.myCareerDummy().first!)
}
