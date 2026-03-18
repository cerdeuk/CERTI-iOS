//
//  ResumeActivityListComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeActivityListComponent: View {
    let model: ActivityModel
    let onTapCard: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                let periodText = "\(model.startAt.toYearMonth()) ~ \(model.endAt.toYearMonth())"

                Text(periodText)                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(height: 18)
                
                Text(model.name)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(height: 18)
                    .padding(.top, 12)
            }
            .frame(width: 104, height: 48)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(model.place)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(width: 137, height: 22, alignment: .leading)
                
                Text(model.description)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .lineLimit(1)
                    .frame(width: 137, height: 18, alignment: .leading)
                    .padding(.top, 10)
            }
            .frame(width: 137)
            .padding(.leading, 29)
            
            Spacer()
        }
        .onTapGesture {
            onTapCard()
        }
    }
}

#Preview {
    ResumeActivityListComponent(model: ActivityModel(
        activityId: 1,
        startAt: "2021.11",
        endAt: "2022.01",
        name: "sopt",
        place: "동아리 36기 기획",
        description: "서비스 기획 및 아이디어 도출"
    ), onTapCard: {})
}
