//
//  CharLimitTextField.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct CharLimitTextField: View {
    @Binding var text: String

    var maxLength: Int
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(
                "", text: $text,
                prompt: Text("텍스트를 입력해주세요.")
                    .foregroundColor(.grayscale300)
            ).maxLength(maxLength, text: $text)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(.grayscale600)
            
            Rectangle()
                 .frame(height: 1)
                 .foregroundColor(.grayscale100)
                 .padding(.top, 8)
                 .padding(.bottom, 8)

            HStack {
                Spacer()
                Text("\(text.count)/\(maxLength)")
                    .applyCertiFont(.caption_semibold_14)
                    .foregroundStyle(.grayscale300)
                    .frame(height: 20)
            }
        }
    }
}
