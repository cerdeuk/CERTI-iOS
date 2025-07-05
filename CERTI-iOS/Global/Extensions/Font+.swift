//
//  Font+.swift
//  CERTI-iOS
//
//  Created by 이상엽 on 7/4/25.
//

import SwiftUI

enum CertiFont {
    case title_bold_24
    case title_bold_22

    case sub_bold_20
    case sub_semibold_20

    case body_bold_18
    case body_semibold_18
    case body_bold_16
    case body_semibold_16
    case body_regular_16

    case caption_bold_14
    case caption_semibold_14
    case caption_regular_14
    case caption_semibold_12
    case caption_regular_12
    
    case caption_semibold_10
    case caption_regular_10

    var font: Font {
        switch self {
        case .title_bold_24:       return .custom("Pretendard-Bold", size: 24)
        case .title_bold_22:       return .custom("Pretendard-Bold", size: 22)

        case .sub_bold_20:         return .custom("Pretendard-Bold", size: 20)
        case .sub_semibold_20:     return .custom("Pretendard-SemiBold", size: 20)

        case .body_bold_18:        return .custom("Pretendard-Bold", size: 18)
        case .body_semibold_18:    return .custom("Pretendard-SemiBold", size: 18)
        case .body_bold_16:        return .custom("Pretendard-Bold", size: 16)
        case .body_semibold_16:    return .custom("Pretendard-SemiBold", size: 16)
        case .body_regular_16:     return .custom("Pretendard-Regular", size: 16)

        case .caption_bold_14:     return .custom("Pretendard-Bold", size: 14)
        case .caption_semibold_14: return .custom("Pretendard-SemiBold", size: 14)
        case .caption_regular_14:  return .custom("Pretendard-Regular", size: 14)
        case .caption_semibold_12: return .custom("Pretendard-SemiBold", size: 12)
        case .caption_regular_12:  return .custom("Pretendard-Regular", size: 12)
       
        case .caption_semibold_10: return .custom("Pretendard-SemiBold", size: 10)
        case .caption_regular_10:  return .custom("Pretendard-Regular", size: 10)
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .title_bold_24, .title_bold_22:
            return 1.2
        case .sub_bold_20, .sub_semibold_20:
            return 1.3
        case .body_bold_18, .body_semibold_18,
             .body_bold_16, .body_semibold_16, .body_regular_16,
             .caption_bold_14, .caption_semibold_14, .caption_regular_14:
            return 1.4
        case .caption_semibold_12, .caption_regular_12, .caption_semibold_10, .caption_regular_10:
            return 1.5
        }
    }

    var letterSpacing: CGFloat {
        switch self {
        case .title_bold_24:
            return -0.016
        case .title_bold_22:
            return -0.014
        case .sub_bold_20, .sub_semibold_20:
            return -0.01
        case .body_bold_18, .body_semibold_18:
            return -0.005
        case .body_bold_16, .body_semibold_16, .body_regular_16,
             .caption_bold_14, .caption_semibold_14, .caption_regular_14:
            return 0
        case .caption_semibold_12, .caption_regular_12:
            return 0.008
        case .caption_semibold_10, .caption_regular_10:
            return 0.01
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .title_bold_24: return 24
        case .title_bold_22: return 22
        case .sub_bold_20, .sub_semibold_20: return 20
        case .body_bold_18, .body_semibold_18: return 18
        case .body_bold_16, .body_semibold_16, .body_regular_16: return 16
        case .caption_bold_14, .caption_semibold_14, .caption_regular_14: return 14
        case .caption_semibold_12, .caption_regular_12: return 12
        case .caption_semibold_10, .caption_regular_10: return 10
        }
    }
}

struct ApplyCertiFontModifier: ViewModifier {
    let style: CertiFont

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.fontSize * (style.lineHeight - 1))
            .kerning(style.letterSpacing * style.fontSize)
    }
}

extension View {
    func applyCertiFont(_ style: CertiFont) -> some View {
        self.modifier(ApplyCertiFontModifier(style: style))
    }
}
