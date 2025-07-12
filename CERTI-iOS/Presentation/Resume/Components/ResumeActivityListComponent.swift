//
//  ResumeActivityListComponent.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/12/25.
//

import SwiftUI

struct ResumeActivityListComponent: View {
    var startAt: String = "2021.11"
    var endAt: String = "2022.01"
    var name: String = "패션디자이너 인턴ㅇ"
    var place: String = "서티그룹ㅇㅇㅇㅇㅇㅇ"
    var discription: String = "트렌드 리서치 및 소재 조사ㅇ"
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                Text("\(startAt) ~ \(endAt)")
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(width: 104, height: 18)
                
                Text(place)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale500)
                    .frame(width: 105, height: 18)
                    .padding(.top, 12)
            }
            .frame(width: 104, height: 48)

            Spacer()
            
            VStack(spacing: 0) {
                Text(name)
                    .applyCertiFont(.body_semibold_16)
                    .foregroundStyle(.grayscale600)
                    .frame(width: 137, height: 22)
                
                Text(discription)
                    .applyCertiFont(.caption_regular_12)
                    .foregroundStyle(.grayscale600)
                    .lineLimit(1)
                    .frame(width: 138, height: 18)
                    .padding(.top, 10)
            }
            .frame(width: 137, height: 50)
        }
    }
}

#Preview {
    ResumeActivityListComponent()
}
