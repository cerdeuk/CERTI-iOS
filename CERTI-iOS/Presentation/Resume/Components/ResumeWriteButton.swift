//
//  ResumeWriteButton.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/13/25.
//

import SwiftUI

struct ResumeWriteButton: View {
    let action: () -> Void
    @Binding var textEmpty: Bool
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("추가하기")
                .applyCertiFont(.body_semibold_16)
                .foregroundStyle(textEmpty ? .white : .grayscale400)
                .frame(width: 335, height: 56)
                .background(textEmpty ? .purpleblue : .grayscale100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
        }
    }
}

private func testButtonClicked() {
    print("testButtonClicked")
}

