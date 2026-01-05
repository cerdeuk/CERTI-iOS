//
//  ToastMessageView.swift
//  CERTI-iOS
//
//  Created by OneTen on 11/2/25.
//

import SwiftUI

struct ToastMessageView: View {
    enum Style {
        case agreeMarketing
        
        var textColor: Color {
            switch self {
            case .agreeMarketing: return .white
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .agreeMarketing: return Color.mainblue
            }
        }
        
        var borderColor: Color? {
            switch self {
            case .agreeMarketing: return nil
            }
        }
    }

    let message: String
    let style: Style

    var body: some View {
        switch style {
        case .agreeMarketing:
            Text(message)
                .applyCertiFont(.caption_semibold_14)
                .foregroundStyle(style.textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(style.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        
    }
}

#Preview("marketing") {
    ToastMessageView(message: "광고성 정보를 받는 것에 동의했어요. 2025. 10. 8", style: .agreeMarketing)
}
