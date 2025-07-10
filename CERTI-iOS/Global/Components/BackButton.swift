//
//  BackButton.swift
//  CERTI-iOS
//
//  Created by 김나연 on 7/10/25.
//

import SwiftUI

struct BackButton: View {
    let onBack: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                onBack()
            } label: {
                Image(.iconArrowleft36)
            }
            
            Spacer()

        }
        .padding(.top, 16)
        .padding(.leading, 20)
    }
}
