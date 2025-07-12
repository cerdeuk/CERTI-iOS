//
//  CharLimitTextField.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct CharLimitTextField: View {
    @State private var info: String = ""
    var maxLength: Int
    
    var body: some View {
        VStack {
            TextField(
                "텍스트를 작성해주세요.",
                text: $info
            ).maxLength(maxLength, text: $info)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.grayscale300)
            
            Rectangle()
                 .frame(height: 1)
                 .foregroundColor(.grayscale100)
                 .padding(.top, 8)
                 .padding(.bottom, 8)


            HStack {
                Spacer()
                Text("\(info.count)/\(maxLength)")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale300)
                    .frame(height: 20)
            }
        }
    }
}

#Preview {
    CharLimitTextField(maxLength: 10)
}
